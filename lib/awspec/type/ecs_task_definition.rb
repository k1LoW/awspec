module Awspec::Type
  class EcsTaskDefinition < ResourceBase
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

    STATES = %w(ACTIVE INACTIVE)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status == state
      end
    end
  end
end
