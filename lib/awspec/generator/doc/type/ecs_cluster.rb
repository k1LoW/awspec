module Awspec::Generator
  module Doc
    module Type
      class EcsCluster < Base
        def initialize
          super
          @type = Awspec::Type::EcsCluster.new('my-ecs-cluster')
          @matchers = [
            Awspec::Type::EcsCluster::STATES.map { |state| 'be_' + state.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::EcsCluster::STATES.map { |state| 'be_' + state.downcase }
          @describes = []
        end
      end
    end
  end
end
