module Awspec::Helper
  module Finder
    module Cloudwatch
      def find_cloudwatch_alarm(id)
        res = @cloudwatch_client.describe_alarms({
                                                   alarm_names: [id]
                                                 })
        return res[:metric_alarms].first if res[:metric_alarms].count == 1

        res = @cloudwatch_client.describe_alarms
        res[:metric_alarms].find do |alarm|
          alarm[:alarm_arn] == id
        end
      end
    end
  end
end
