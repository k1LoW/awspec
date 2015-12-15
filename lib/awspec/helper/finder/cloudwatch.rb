module Awspec::Helper
  module Finder
    module Cloudwatch
      def find_cloudwatch_alarm(id)
        res = cloudwatch_client.describe_alarms({
                                                  alarm_names: [id]
                                                })
        return res[:metric_alarms].first if res[:metric_alarms].count == 1

        res = cloudwatch_client.describe_alarms
        res[:metric_alarms].find do |alarm|
          alarm[:alarm_arn] == id
        end
      end

      def select_all_cloudwatch_alarms
        selected = []
        res = cloudwatch_client.describe_alarms

        loop do
          selected += res.metric_alarms
          (res.next_page? && res = res.next_page) || break
        end

        selected
      end
    end
  end
end
