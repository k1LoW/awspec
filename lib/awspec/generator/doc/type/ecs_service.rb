module Awspec::Generator
  module Doc
    module Type
      class EcsService < Base
        def initialize
          super
          @type = Awspec::Type::Ecs.new('my-ecs-service')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
