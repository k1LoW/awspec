module Awspec::Helper
  module Finder
    module CloudwatchLogs
      def find_cloudwatch_logs_group(id)
        cloudwatch_logs_client.describe_log_groups({ log_group_name_prefix: id }).log_groups.last
      end

      def find_cloudwatch_logs_stream(id)
        cloudwatch_logs_client.describe_log_streams({ log_group_name: id }).log_streams.last
      end

      def find_cloudwatch_logs_metric_fileter(id, filter_name)
        cloudwatch_logs_client.describe_metric_filters({
                                                         log_group_name: id,
                                                         filter_name_prefix: filter_name
                                                       }).metric_filters.last
      end

      def find_cloudwatch_logs_subscription_fileter(id, filter_name)
        cloudwatch_logs_client.describe_subscription_filters({
                                                               log_group_name: id,
                                                               filter_name_prefix: filter_name
                                                             }).subscription_filters.last
      end
    end
  end
end
