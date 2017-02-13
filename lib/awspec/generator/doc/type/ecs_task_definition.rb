module Awspec::Generator
  module Doc
    module Type
      class EcsTaskDefinition < Base
        def initialize
          super
          @type_name = 'ECS Task Definition'
          @type = Awspec::Type::EcsTaskDefinition.new('my-ecs-taskdef')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::EcsTaskDefinition::STATES.map { |state| 'be_' + state.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::EcsTaskDefinition::STATES.map { |state| 'be_' + state.downcase }
          @describes = []
        end
      end
    end
  end
end
