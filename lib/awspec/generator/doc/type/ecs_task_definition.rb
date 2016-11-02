module Awspec::Generator
  module Doc
    module Type
      class EcsTaskDefinition < Base
        def initialize
          super
          @type = Awspec::Type::Ecs.new('my-ecs-taskdef')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
