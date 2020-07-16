module Awspec::Type
  class CloudwatchLogs < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_cloudwatch_logs_group(@display_name)
    end

    def id
      @id ||= resource_via_client.log_group_name if resource_via_client
    end

    def has_log_stream?(stream_name)
      ret = find_cloudwatch_logs_stream_by_log_group_name(@id, stream_name)
      return true if ret == stream_name
    end

    def has_metric_filter?(filter_name)
      ret = find_cloudwatch_logs_metric_fileter_by_log_group_name(@id, filter_name).filter_name
      return true if ret == filter_name
    end

    def has_subscription_filter?(filter_name, pattern = nil)
      ret = find_cloudwatch_logs_subscription_fileter_by_log_group_name(@id, filter_name)
      if pattern.nil?
        return true if ret.filter_name == filter_name
      else
        return false unless ret.filter_pattern == pattern
      end
      return true if ret.filter_name == filter_name
    end

    def has_tag?(tag_key, tag_value)
      find_tags_by_log_group_name(resource_via_client.log_group_name).find do |key, value|
        key == tag_key && value == tag_value
      end
    end
  end
end
