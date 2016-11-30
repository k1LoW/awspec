module Awspec::Type
  class EcsContainerInstance < Base
    aws_resource Aws::ECS::Types::ContainerInstance

    attr_accessor :cluster_name

    def initialize(container_instance)
      super
      @display_name = container_instance.split('/').last
    end

    def resource_via_client
      @resource_via_client ||= find_ecs_container_instances(@cluster_name, [@display_name]).first
    end

    def id
      @id ||= resource_via_client.container_instance_arn if resource_via_client
    end

    def cluster_name
      @cluster_name || 'default'
    end

    def active?
      resource_via_client.status == 'ACTIVE'
    end

    def inactive?
      resource_via_client.status == 'INACTIVE'
    end
  end
end
