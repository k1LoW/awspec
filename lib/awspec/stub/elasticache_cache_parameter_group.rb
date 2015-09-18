Aws.config[:elasticache] = {
  stub_responses: {
    describe_cache_parameters: {
      parameters: [
        {
          parameter_name: 'activerehashing',
          parameter_value: 'yes'
        },
        {
          parameter_name: 'client-output-buffer-limit-pubsub-hard-limit',
          parameter_value: '33554432'
        }
      ]
    }
  }
}
