# rubocop:disable all
Aws.config[:cloudwatch] = {
  stub_responses: {
    describe_alarms: {
      metric_alarms: [
        {
          alarm_name: 'my-cloudwatch-alarm',
          alarm_arn: 'arn:aws:cloudwatch:ap-northeast-1:1234567890:alarm:my_NumberOfProcesses',
          alarm_description: 'my_NumberOfProcesses',
          alarm_configuration_updated_timestamp: Time.new(2015, 1, 2, 10, 00, 00, '+00:00'),
          actions_enabled: true,
          ok_actions: ['arn:aws:sns:ap-northeast-1:1234567890:sns_alert'],
          alarm_actions: ['arn:aws:sns:ap-northeast-1:1234567890:sns_alert'],
          insufficient_data_actions: ['arn:aws:sns:ap-northeast-1:1234567890:sns_alert'],
          state_value: 'OK',
          state_reason: 'Threshold Crossed: 1 datapoint (53.0) was not less than or equal to the threshold (5.0).',
          state_reason_data:
            '{\'version\':\'1.0\',\'queryDate\':\'2015-04-04T01:06:26.904+0000\',\'startDate\':\'2015-04-04T01:01:00.000+0000\',\'statistic\':\'Average\',\'period\':300,\'recentDatapoints\':[53.0],\'threshold\':5.0}',
          state_updated_timestamp: Time.new(2015, 1, 2, 10, 10, 00, '+00:00'),
          metric_name: 'NumberOfProcesses',
          namespace: 'my-cloudwatch-namespace',
          statistic: 'Average',
          dimensions:
            [
              {
                name: 'name',
                value: 'my-dimension'
              }
            ],
          period: 300,
          unit: 'Seconds',
          evaluation_periods: 1,
          datapoints_to_alarm: 1,
          threshold: 5.0,
          comparison_operator: 'LessThanOrEqualToThreshold'
        }
      ]
    }
  }
}
