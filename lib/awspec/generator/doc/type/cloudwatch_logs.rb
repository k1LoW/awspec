module Awspec::Generator
  module Doc
    module Type
      class CloudwatchLogs < Base
        def initialize
          super
          @type_name = 'CloudwatchLogs'
          @type = Awspec::Type::CloudwatchLogs.new('my-cloudwatch-logs-group')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
