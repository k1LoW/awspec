module Awspec::Generator
  module Doc
    module Type
      class CloudwatchAlarm < Base
        def initialize
          super
          @type_name = 'CloudwatchAlarm'
          @type = Awspec::Type::CloudwatchAlarm.new('my-cloudwatch-alarm')
          @ret = @type.resource_via_client
          @matchers = %w(belong_to_metric)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
