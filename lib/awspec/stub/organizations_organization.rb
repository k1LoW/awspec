Aws.config[:organizations] = {
  stub_responses: {
    describe_organization: {
      organization: {
        id: 'o-exampleorgid',
        arn: 'arn:aws:organizations::111111111111:organization/o-exampleorgid',
        feature_set: 'ALL',
        master_account_arn: 'arn:aws:organizations::111111111111:account/o-exampleorgid/111111111111',
        master_account_id: '111111111111',
        master_account_email: 'test@example.com',
        available_policy_types: [
          {
            type: 'SERVICE_CONTROL_POLICY',
            status: 'ENABLED'
          }
        ]
      }
    }
  }
}
