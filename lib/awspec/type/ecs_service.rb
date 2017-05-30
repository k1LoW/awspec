module Awspec::Type
  class EcsService < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_ecs_service(@display_name)
    end

    def id
      @id ||= resource_via_client.service_name if resource_via_client
    end

    STATES = %w(ACTIVE DRAINING INACTIVE)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status == state
      end
    end
  end
end
