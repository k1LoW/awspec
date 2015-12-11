module Awspec::Generator
  module Doc
    module Type
      class AutoscalingGroup < Base
        def initialize
          super
          @type = Awspec::Type::AutoscalingGroup.new('my-auto-scaling-group')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
