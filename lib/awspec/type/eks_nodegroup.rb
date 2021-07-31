require 'set'

module Awspec::Type
  class EksNodeEC2
    attr_reader :state, :subnet_id, :sec_groups

    def initialize(id, state, subnet_id, sec_groups)
      @id = id
      @state = state
      @subnet_id = subnet_id
      @sec_groups = sec_groups
    end

    def to_s
      "ID: #{@id}, State: #{@state}, Subnet ID: #{@subnet_id}, Security Groups: #{@sec_groups}"
    end
  end

  class EksNodeSecGroup
    attr_reader :name, :id

    def initialize(id, name)
      @id = id
      @name = name
    end

    def to_s
      "ID: #{@id}, Name: #{@name}"
    end
  end

  class EksNodegroup < ResourceBase
    # the tags below are standard for EKS node groups instances
    EKS_CLUSTER_TAG = 'tag:eks:cluster-name'
    EKS_NODEGROUP_TAG = 'tag:eks:nodegroup-name'

    attr_accessor :cluster

    def initialize(group_name)
      super
      @group_name = group_name
      @ec2_instances = []
      @sec_groups = Set.new
      @sec_groups_ids = Set.new
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

    def subnets
      ec2_instances = find_nodes
      Set.new(ec2_instances.map { |ec2| ec2.subnet_id })
    end

    def has_security_group?(sec_group)
      if @sec_groups.empty? or @sec_groups_ids.empty?
        ec2_instances = find_nodes

        ec2_instances.each do |ec2|
          ec2.sec_groups.each do |sg|
            @sec_groups.add(sg.name)
            @sec_groups_ids.add(sg.id)
          end
        end
      end

      @sec_groups.member?(sec_group) or @sec_groups_ids.member?(sec_group)
    end

    def ready?
      min_expected = resource_via_client.scaling_config.min_size
      ec2_instances = find_nodes
      running_counter = 0

      ec2_instances.each do |ec2|
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
      return @ec2_instances unless @ec2_instances.empty?

      result = ec2_client.describe_instances(
        {
          filters: [
            { name: EKS_CLUSTER_TAG, values: [cluster] },
            { name: EKS_NODEGROUP_TAG, values: [@group_name] }
          ]
        }
      )
      result.reservations.each do |reservation|
        reservation.instances.each do |instance|
          sec_groups = []

          instance.security_groups.map do |sg|
            sec_groups.append(EksNodeSecGroup.new(sg.group_id, sg.group_name))
          end

          @ec2_instances.append(
            EksNodeEC2.new(
              instance.instance_id,
              instance.state.name,
              instance.subnet_id,
              sec_groups
            )
          )
        end
      end

      @ec2_instances
    end
  end
end
