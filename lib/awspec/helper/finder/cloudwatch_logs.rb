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

      def last_cloudwatch_logs_stream_by_log_group_name(id)
        cloudwatch_logs_client.describe_log_streams({ log_group_name: id }).log_streams.last
      end

      def find_cloudwatch_logs_stream_by_log_group_name(id, stream_name)
        req = {
          log_group_name: id,
          log_stream_name_prefix: stream_name
        }
        ret = nil
        loop do
          res = cloudwatch_logs_client.describe_log_streams(req)
          res.log_streams.find do |log_stream|
            if log_stream[:log_stream_name] == stream_name
              ret = log_stream[:log_stream_name]
              break
            end
          end
          break if ret.present?
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        ret
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

      def select_all_cloudwatch_logs_log_groups
        req = {}
        log_groups = []
        loop do
          res = cloudwatch_logs_client.describe_log_groups(req)
          log_groups.push(*res.log_groups)
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        log_groups
      end

      def find_tags_by_log_group_name(id)
        cloudwatch_logs_client.list_tags_log_group(log_group_name: id)[:tags]
      end

      filter_types = %w(metric subscription)
      filter_types.each do |type|
        define_method 'select_all_cloudwatch_logs_' + type + '_filter' do |*args|
          req = { log_group_name: args.first }
          method_name = 'describe_' + type + '_filters'
          resources = []
          loop do
            res = cloudwatch_logs_client.send(method_name, req)
            case type
            when 'metric' then
              resources.push(*res.metric_filters)
            when 'subscription' then
              resources.push(*res.subscription_filters)
            end
            break if res.next_token.nil?
            req[:next_token] = res.next_token
          end
          resources
        end
      end
    end
  end
end
