module Awspec::Helper
  module Finder
    module CloudwatchEvent
      def find_cloudwatch_event(id)
        cloudwatch_event_client.list_rules.rules.find do |rule|
          rule.name == id || rule.arn == id
        end
      end

      def select_all_cloudwatch_events
        cloudwatch_event_client.list_rules.rules
      end
    end
  end
end
