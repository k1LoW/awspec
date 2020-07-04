Aws.config[:cognitoidentity] = {
  stub_responses: {
    list_identity_pools: {
      identity_pools: [
        {
          identity_pool_id: 'us-east-1:adsfkjaekljnfg234',
          identity_pool_name: 'my-cognito-identity-pool'
        },
        {
          identity_pool_id: 'us-east-1:gfdksjg87sfna943knbj',
          identity_pool_name: 'My_Identity_Pool'
        }
      ], next_token: 'akvjnkjndgoierhteuh7sfdnre9erglkwnroijsdfinewr=='
    }
  }
}
