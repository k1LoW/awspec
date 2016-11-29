module Awspec::Type
  class EcsContainerInstance < Base
    aws_resource Aws::ECS::Types::ContainerInstance

    def initialize(cluster_name, name_or_resource)
      @cluster_name = cluster_name
      if String == name_or_resource
        @display_name = name_or_resource
      else
        @resource_via_client = name_or_resource
        @display_name = uuid
      end
      super(@display_name)
    end

    def resource_via_client
      @resource_via_client ||= find_ecs_container_instance(@cluster_name, @display_name)
    end

    def uuid
      @uuid ||= resource_via_client.container_instance_arn.split('/').last if resource_via_client
    end

    alias_method :id, :uuid

    def active?
      resource_via_client.status == 'ACTIVE'
    end

    def inactive?
      resource_via_client.status == 'INACTIVE'
    end
  end
end
