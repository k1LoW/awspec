module Awspec::Generator
  module Doc
    module Type
      class EcsCluster < Base
        def initialize
          super
          @type = Awspec::Type::EcsCluster.new('my-ecs-cluster')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
