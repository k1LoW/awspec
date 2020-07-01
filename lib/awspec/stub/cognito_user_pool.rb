Aws.config[:cognitoidentityprovider] = {
  stub_responses: {
    list_user_pools: {
      user_pools: [
        {
          id: 'us-east-1_6adfkj4ju',
          name: 'my-cognito-user-pool',
          lambda_config: {
            pre_sign_up: nil,
            custom_message: nil,
            post_confirmation: nil,
            pre_authentication: nil,
            post_authentication: nil,
            define_auth_challenge: nil,
            create_auth_challenge: nil,
            verify_auth_challenge_response: nil,
            pre_token_generation: nil,
            user_migration: nil
          },
          status: nil,
          last_modified_date: Time.new(2016, 5, 5, 5, 00, 00, '+00:00'),
          creation_date: Time.new(2015, 1, 2, 10, 00, 00, '+00:00')
        },
        {
          id: 'us-east-1_12345adsf',
          name: 'test-pool',
          lambda_config: {
            pre_sign_up: nil,
            custom_message: nil,
            post_confirmation: nil,
            pre_authentication: nil,
            post_authentication: nil,
            define_auth_challenge: nil,
            create_auth_challenge: nil,
            verify_auth_challenge_response: nil,
            pre_token_generation: nil,
            user_migration: nil
          },
          status: nil,
          last_modified_date: Time.new(2019, 1, 2, 10, 00, 00, '+00:00'),
          creation_date: Time.new(2018, 1, 2, 10, 00, 00, '+00:00')
        }
      ],
      next_token: 'aoeijfasdnvakldsjfgoai'
    }
  }
}
