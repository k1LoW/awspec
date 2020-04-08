Aws.config[:ssm] = {
  stub_responses: {
    get_parameter: {
      parameter:
      {
        name: 'my-parameter',
        type: 'SecureString',
        version: 1,
        arn: 'arn:aws:ssm:REGION:ACCOUNT_ID:parameter/my-parameter',
        value: 'encrypted'
      }
    }
  }
}
