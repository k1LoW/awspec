module Awspec::Type
  class EKSNodeEC2
    attr_reader :state, :subnet_id, :sec_groups

    def initialize(id, state, subnet_id, security_groups)
      @id = id
      @state = state
      @subnet_id = subnet_id
      @sec_groups = security_groups
    end

    def to_s
      "ID: #{@id}, State: #{@state}, Subnet ID: #{@subnet_id}, Security Groups: #{@sec_groups}"
    end
  end

  class EksNodegroup < ResourceBase

    # the tags below are standard for EKS node groups instances
    @@eks_cluster_tag = 'tag:eks:cluster-name'
    @@eks_nodegroup_tag = 'tag:eks:nodegroup-name'

    attr_accessor :cluster

    def initialize(group_name)
      super
      @group_name = group_name
      @ec2_instances = []
    end

    def resource_via_client
      @resource_via_client ||= find_eks_nodegroup(cluster, @group_name)
    end

    def id
      @id ||= resource_via_client.nodegroup_arn if resource_via_client
    end

    def cluster
      @cluster || 'default'
    end

    def belong_to_subnets(subnets)
    end

    def has_security_group(sec_group)
    end

    def ready?
      min_expected = resource_via_client.scaling_config.min_size
      ec2_instances = find_nodes
      running_counter = 0

      ec2_instances.each do |ec2|
        puts ec2
        running_counter += 1 if ec2.state.eql?('running')
        break if running_counter == min_expected
      end

      running_counter >= min_expected
    end

    STATES = %w(ACTIVE INACTIVE)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status == state
      end
    end

    private

    def find_nodes
      return @ec2_instances if ! @ec2_instances.empty?

      result = ec2_client.describe_instances(
        {
          filters: [
            { name: @@eks_cluster_tag, values: [cluster] },
            { name: @@eks_nodegroup_tag, values: [@group_name] }
          ]
        }
      )
      result.reservations.each do |reservation|
        reservation.instances.each do |instance|
          @ec2_instances.append(
            EKSNodeEC2.new(
              instance.instance_id,
              instance.state.name,
              instance.subnet_id,
              instance.security_groups.map { |sg| sg.group_id }
            )
          )
        end
      end

      @ec2_instances
    end
  end
end
