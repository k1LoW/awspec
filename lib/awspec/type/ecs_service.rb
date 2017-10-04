module Awspec::Type
  class EcsService < ResourceBase
    attr_accessor :cluster
    def initialize(service)
      super
      @display_name = service
    end

    def resource_via_client
      @resource_via_client ||= find_ecs_service(cluster, @display_name)
    end

    def id
      @id ||= resource_via_client.service_name if resource_via_client
    end

    def cluster
      @cluster || 'default'
    end

    STATES = %w(ACTIVE DRAINING INACTIVE)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status == state
      end
    end
  end
end
