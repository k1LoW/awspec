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
        },
        {
          parameter_name: 'repl-timeout',
          parameter_value: '60'
        },
        {
          parameter_name: 'timeout',
          parameter_value: '0'
        },
        {
          parameter_name: 'tcp-keepalive',
          parameter_value: '300'
        }
      ]
    }
  }
}
