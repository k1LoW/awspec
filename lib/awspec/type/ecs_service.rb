module Awspec::Type
  class EcsService < Base
    aws_resource Aws::ECS::Types::Service

    def initialize(service)
      super
      @display_name = service
    end

    def resource_via_client
      @resource_via_client ||= find_ecs_service(@display_name)
    end

    def id
      @id ||= resource_via_client.service_name if resource_via_client
    end

    def active?
      resource_via_client.status == 'ACTIVE'
    end

    def draining?
      resource_via_client.status == 'DRAINING'
    end

    def inactive?
      resource_via_client.status == 'INACTIVE'
    end
  end
end
