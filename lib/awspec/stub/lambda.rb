Aws.config[:lambda] = {
  stub_responses: {
    list_functions: {
      functions: [
        {
          function_name: 'my-lambda-function-name',
          function_arn: 'arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function-name',
          description: 'My Lambda Function',
          runtime: 'python2.7',
          handler: 'lambda_function.lambda_handler',
          timeout: 5,
          memory_size: 256,
          code_size: 1234,
          last_modified: Time.new(2018, 12, 05, 19, 10, 44, '+00:00'),
          code_sha_256: 'LAI9GRLpJD/dq2D7Uopwaeh354tsd8fQsSI6eSH0xOIs=',
          version: '$LATEST',
          role: 'arn:aws:iam::123456789:role/foobarVPCRole',
          kms_key_arn: nil,
          revision_id: '8d01897515-bcb0-43c7-9b14-e6d14fyyff4d',
          layers: nil,
          tracing_config:
            # <struct Aws::Lambda::Types::TracingConfigResponse mode="PassThrough">
            {
              mode: 'PassThrough'
            },
          environment:
            # <struct Aws::Lambda::Types::EnvironmentResponse
            {
              variables:
                {
                  'ENDPOINT_URL' => 'https://foobar.sns.us-east-1.vpce.amazonaws.com',
                  'ENV_NAME' => 'QA',
                  'LOG_LEVEL' => 'DEBUG',
                  'FOOBAR_TOPIC' => 'arn:aws:sns:us-east-1:123456789:FoobarManager',
                  'RESOLVER1' => '10.196.138.1',
                  'RESOLVER2' => '10.196.136.2'
                },
              error: nil
            }
        }
      ]
    },
    list_event_source_mappings: {
      # @todo
    }
  }
}
