# rubocop:disable all
Aws.config[:cloudwatchevents] = {
  stub_responses: {
    list_rules: {
      rules: [
        {
          name: 'my-cloudwatch-event',
          state: 'ENABLED',
          schedule_expression: 'cron(* * * * * *)',
          arn: 'arn:aws:events:ap-northeast-1:1234567890:rule/my_cloudwatch_event'
        }
      ]
    }
  }
}