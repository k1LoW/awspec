module Awspec::Helper
  module Finder
    module CloudwatchLogs
      def find_cloudwatch_logs_group(id)
        cloudwatch_logs_client.describe_log_groups({
                                                     log_group_name_prefix: id
                                                   }).log_groups.find do |log_group|
          log_group.log_group_name == id
        end
      end

      def find_cloudwatch_logs_stream_by_log_group_name(id)
        cloudwatch_logs_client.describe_log_streams({ log_group_name: id }).log_streams.last
      end

      def find_cloudwatch_logs_metric_fileter_by_log_group_name(id, filter_name)
        cloudwatch_logs_client.describe_metric_filters({
                                                         log_group_name: id,
                                                         filter_name_prefix: filter_name
                                                       }).metric_filters.find do |filter|
          filter.filter_name == filter_name
        end
      end

      def find_cloudwatch_logs_subscription_fileter_by_log_group_name(id, filter_name)
        cloudwatch_logs_client.describe_subscription_filters({
                                                               log_group_name: id,
                                                               filter_name_prefix: filter_name
                                                             }).subscription_filters.find do |filter|
          filter.filter_name == filter_name
        end
      end
    end
  end
end
