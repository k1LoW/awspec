Aws.config[:lambda] = {
  stub_responses: {
    list_functions: {
      functions: [
        {
          function_name: 'my-lambda-function-name',
          function_arn: 'arn:aws:lambda:us-east-1:123456789012:function:my-other-lambda-function-name',
          runtime: 'python2.7',
          handler: 'lambda_function.lambda_handler',
          role: 'arn:aws:iam::123456789000:role/lambda_role',
          code_size: 1234,
          description: 'My Lambda Function',
          timeout: 5,
          memory_size: 256,
          last_modified: Time.now,
          code_sha_256: 'Js8wRegsTzy6pbFBb46mMxwMnQYFHftWQ5WTbGP9xXj=',
          version: '$LATEST',
          vpc_config: nil,
          environment: {
            variables: {
              'key_a' => 'value_a', 'key_b' => 'value_b'
            }
          }
        },
        {
          function_name: 'my-other-lambda-function-name',
          function_arn: 'arn:aws:lambda:us-east-1:123456789012:function:my-other-lambda-function-name'
        }
      ]
    },
    get_function_configuration: {
      function_name: 'my-other-lambda-function-name',
      function_arn: 'arn:aws:lambda:us-east-1:123456789012:function:my-other-lambda-function-name',
      runtime: 'python2.7',
      handler: 'lambda_function.lambda_handler',
      role: 'arn:aws:iam::123456789000:role/lambda_role',
      code_size: 1234,
      description: 'My Lambda Function',
      timeout: 5,
      memory_size: 256,
      last_modified: Time.now,
      code_sha_256: 'Js8wRegsTzy6pbFBb46mMxwMnQYFHftWQ5WTbGP9xXj=',
      version: '$LATEST',
      vpc_config: nil,
      environment: {
        variables: {
          'key_a' => 'value_a', 'key_b' => 'value_b'
        }
      }
    },
    list_event_source_mappings: {
      # @todo
    }
  }
}
