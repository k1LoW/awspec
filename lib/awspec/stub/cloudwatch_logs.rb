Aws.config[:cloudwatchlogs] = {
  stub_responses: {
    describe_log_groups: {
      log_groups: [
        {
          log_group_name: 'my-cloudwatch-logs-group',
          retention_in_days: 365
        }
      ]
    },
    describe_log_streams: {
      log_streams: [
        {
          log_stream_name: 'my-cloudwatch-logs-stream'
        }
      ]
    },
    describe_metric_filters: {
      metric_filters: [
        {
          filter_name: 'my-cloudwatch-logs-metric-filter'
        }
      ]
    },
    describe_subscription_filters: {
      subscription_filters: [
        {
          filter_name: 'my-cloudwatch-logs-subscription-filter',
          filter_pattern: '[host, ident, authuser, date, request, status, bytes]'
        }
      ]
    },
    list_tags_log_group: {
      tags: {
        'key_one' => 'value_one',
        'key_two' => 'value_two'
      }
    }

  }
}
