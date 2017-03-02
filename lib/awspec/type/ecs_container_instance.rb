module Awspec::Type
  class EcsContainerInstance < ResourceBase
    attr_accessor :cluster

    def initialize(container_instance)
      super
      @display_name = container_instance.split('/').last
    end

    def resource_via_client
      @resource_via_client ||= find_ecs_container_instance(cluster, @display_name)
    end

    def id
      @id ||= resource_via_client.container_instance_arn if resource_via_client
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
