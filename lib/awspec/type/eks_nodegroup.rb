module Awspec::Type
  class EksNodegroup < ResourceBase
    attr_accessor :cluster

    def initialize(group_name)
      super
      @group_name = group_name
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

    STATES = %w(ACTIVE INACTIVE)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status == state
      end
    end
  end
end
