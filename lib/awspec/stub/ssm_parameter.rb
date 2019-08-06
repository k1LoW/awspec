Aws.config[:ssm] = {
  stub_responses: {
    find_ssm_parameter: {
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
