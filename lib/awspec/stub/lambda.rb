Aws.config[:lambda] = {
  stub_responses: {
    list_functions: {
      functions: [
        {
          function_name: 'my-lambda-function-name',
          function_arn: 'arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function-name',
          description: 'My Lambda Function',
          runtime: 'pyhton2.7',
          handler: 'lambda_function.lambda_handler',
          timeout: 5,
          memory_size: 256,
          code_size: 1234
        }
      ]
    },
    list_event_source_mappings: {
      # @todo
    }
  }
}
