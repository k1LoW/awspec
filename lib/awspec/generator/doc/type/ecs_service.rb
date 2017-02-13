module Awspec::Generator
  module Doc
    module Type
      class EcsService < Base
        def initialize
          super
          @type_name = 'ECS Service'
          @type = Awspec::Type::EcsService.new('my-ecs-service')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::EcsService::STATES.map { |state| 'be_' + state.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::EcsService::STATES.map { |state| 'be_' + state.downcase }
          @describes = []
        end
      end
    end
  end
end
