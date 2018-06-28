Aws.config[:ssm] = {
  stub_responses: {
    describe_parameters: {
      parameters: [
        {
          name: 'my-parameter',
          type: 'SecureString',
          key_id: 'alias/aws/ssm',
          description: 'Some description',
          version: 1,
          next_token: nil
        }
      ]
    }
  }
}
