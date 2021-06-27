module Awspec::Type
  class EKSNodeEC2
    attr_reader :state

    def initialize(id, state)
      @id = id
      @state = state
    end

    def to_s
      "ID: #{@id}, State: #{@state}"
    end
  end

  class EksNodegroup < ResourceBase
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
      return @ec2_instances if ! @ec2_instances.empty?

      # the tags below are standard for EKS node groups instances
      result = ec2_client.describe_instances(
        {
          filters: [
            { name: 'tag:eks:cluster-name', values: [cluster] },
            { name: 'tag:eks:nodegroup-name', values: [@group_name] }
          ]
        }
      )
      result.reservations.each do |reservation|
        reservation.instances.each do |instance|
          @ec2_instances.append(EKSNodeEC2.new(instance.instance_id, instance.state.name))
        end
      end

      @ec2_instances
    end
  end
end
