module Awspec::Type
  class EcsContainerInstance < Base
    aws_resource Aws::ECS::Types::ContainerInstance

    def initialize(container_instance)
      super
      @cluster_name = 'default'
      @display_name = container_instance.split('/').last
    end

    def resource_via_client
      @resource_via_client ||= find_ecs_container_instances(@cluster_name, [@display_name]).first
    end

    def id
      @id ||= resource_via_client.container_instance_arn
    end

    def active?
      resource_via_client.status == 'ACTIVE'
    end

    def inactive?
      resource_via_client.status == 'INACTIVE'
    end
  end
end
