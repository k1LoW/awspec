# rubocop:disable Metrics/LineLength
Aws.config[:cloudformation] = {
  stub_responses: {
    describe_stacks: {
      stacks:  [
        {
          stack_id:
            'arn:aws:cloudformation:ap-northeast-1:123456789012:stack/my-cloudformation-stack/8ksdf6d0-7jia-1lo7-a9j7-5dca9ff482',
          stack_name: 'my-cloudformation-stack',
          change_set_id: nil,
          description: 'The AWS CloudFormation template for this Serverless application',
          parameters: [],
          creation_time: Time.new(2015, 1, 2, 10, 10, 00, '+00:00'),
          last_updated_time: Time.new(2015, 1, 2, 10, 10, 00, '+00:00'),
          stack_status: 'UPDATE_COMPLETE',
          stack_status_reason: nil,
          disable_rollback: false,
          notification_arns: [],
          timeout_in_minutes: nil,
          capabilities: %w(CAPABILITY_IAM CAPABILITY_NAMED_IAM),
          outputs:
            [
              {
                output_key: 'HandlerLambdaFunctionQualifiedArn',
                output_value:
                  'arn:aws:lambda:ap-northeast-1:123456789012:function:my-cloudformation-stack-handler:1',
                description: 'Current Lambda function version'
              },
              {
                output_key: 'ServerlessDeploymentBucketName',
                output_value:
                  'bucket-serverlessdeploymentbuck-sdifase69cjs',
                description: nil
              }
            ],
          role_arn: nil,
          tags:
            [
              {
                key: 'STAGE',
                value: 'production'
              }
            ]
        }
      ],
      next_token: nil
    }
  }
}
