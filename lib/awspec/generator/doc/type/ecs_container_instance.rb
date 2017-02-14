module Awspec::Generator
  module Doc
    module Type
      class EcsContainerInstance < Base
        def initialize
          super
          @type_name = 'ECS Container Instance'
          @type = Awspec::Type::EcsContainerInstance.new('my-ecs-container-instance')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::EcsContainerInstance::STATES.map { |state| 'be_' + state.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::EcsContainerInstance::STATES.map { |state| 'be_' + state.downcase }
          @describes = []
        end
      end
    end
  end
end
