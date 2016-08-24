module Awspec::Generator
  module Doc
    module Type
      class CloudwatchEvent < Base
        def initialize
          super
          @type_name = 'CloudwatchEvent'
          @type = Awspec::Type::CloudwatchEvent.new('my-cloudwatch-event')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
