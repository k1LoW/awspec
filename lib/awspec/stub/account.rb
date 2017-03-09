Aws.config[:ec2] = {
  stub_responses: {
    describe_account_attributes: {
      account_attributes: [
        {
          attribute_name: 'supported-platforms',
          attribute_values: [
            {
              attribute_value: 'EC2'
            },
            {
              attribute_value: 'VPC'
            }
          ]
        },
        {
          attribute_name: 'max-instances',
          attribute_values: [
            {
              attribute_value: '20'
            }
          ]
        }
      ]
    }
  }
}
Aws.config[:ses] = {
  stub_responses: {
    get_send_quota: {
      max_24_hour_send: 200.0,
      max_send_rate: 1.0,
      sent_last_24_hours: 1.0
    }
  }
}
Aws.config[:sts] = {
  stub_responses: {
    get_caller_identity: {
      account: '123456789012',
      arn: 'arn:aws:iam::123456789012:user/Alice',
      user_id: 'AKIAI44QH8DHBEXAMPLE'
    }
  }
}
