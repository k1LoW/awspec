Aws.config[:organizations] = {
  stub_responses: {
    list_accounts: {
      accounts: [
        {
          id: '111111111111',
          arn: 'arn:aws:organizations::111111111111:account/o-exampleorgid/111111111111',
          email: 'master@example.com',
          name: 'Master Account',
          status: 'ACTIVE',
          joined_method: 'CREATED',
          joined_timestamp: Time.new(2017, 4, 4, 9, 00, 00, '+00:00')
        },
        {
          id: '222222222222',
          arn: 'arn:aws:organizations::111111111111:account/o-exampleorgid/222222222222',
          email: 'member2@example.com',
          name: 'Member Account2',
          status: 'ACTIVE',
          joined_method: 'INVITED',
          joined_timestamp: Time.new(2017, 4, 4, 9, 00, 00, '+00:00')
        },
        {
          id: '333333333333',
          arn: 'arn:aws:organizations::111111111111:account/o-exampleorgid/333333333333',
          email: 'member3@example.com',
          name: 'Member Account3',
          status: 'ACTIVE',
          joined_method: 'INVITED',
          joined_timestamp: Time.new(2017, 4, 4, 9, 00, 00, '+00:00')
        }
      ]
    }
  }
}
