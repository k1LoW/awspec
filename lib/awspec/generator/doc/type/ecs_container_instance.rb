module Awspec::Generator
  module Doc
    module Type
      class EcsContainerInstance < Base
        def initialize
          super
          @type = Awspec::Type::EcsContainerInstance.new('my-ecs-container-instance')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
