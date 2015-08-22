module Awspec::Generator
  module Doc
    module Type
      class AutoScalingGroup < Base
        def initialize
          super
          @type = Awspec::Type::AutoScalingGroup.new('my-auto-scaling-group')
          @ret = @type.group
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
