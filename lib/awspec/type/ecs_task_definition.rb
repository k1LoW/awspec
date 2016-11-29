module Awspec::Type
  class EcsTaskDefinition < Base
    aws_resource Aws::ECS::Types::TaskDefinition

    def initialize(taskdef)
      super
      @display_name = taskdef
    end

    def resource_via_client
      @resource_via_client ||= find_ecs_task_definition(@display_name)
    end

    def id
      @id ||= "#{resource_via_client.family}:#{resource_via_client.revision}" if resource_via_client
    end

    def active?
      resource_via_client.status == 'ACTIVE'
    end

    def inactive?
      resource_via_client.status == 'INACTIVE'
    end
  end
end
