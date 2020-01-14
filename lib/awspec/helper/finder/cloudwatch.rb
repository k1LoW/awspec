module Awspec::Helper
  module Finder
    module Cloudwatch
      def find_cloudwatch_alarm(id)
        res = cloudwatch_client.describe_alarms({
                                                  alarm_names: [id]
                                                })
        return res.metric_alarms.first if res.metric_alarms.count == 1

        res = cloudwatch_client.describe_alarms
        alarms = res.metric_alarms.select do |alarm|
          alarm.alarm_arn == id
        end
        alarms.single_resource(id)
      end

      def select_all_cloudwatch_alarms
        selected = []
        res = cloudwatch_client.describe_alarms

        loop do
          selected += res.metric_alarms
          break if res.next_token.nil?
          res = cloudwatch_client.describe_alarms({
                                                    next_token: res.next_token
                                                  })
        end

        selected
      end
    end
  end
end
