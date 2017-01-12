module Awspec::Generator
  module Doc
    module Type
      class EcsTaskDefinition < Base
        def initialize
          super
          @type = Awspec::Type::EcsTaskDefinition.new('my-ecs-taskdef')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
