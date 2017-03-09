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
          attribute_name: 'vpc-max-security-groups-per-interface',
          attribute_values: [
            {
              attribute_value: '5'
            }
          ]
        },
        {
          attribute_name: 'max-elastic-ips',
          attribute_values: [
            {
              attribute_value: '5'
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
        },
        {
          attribute_name: 'vpc-max-elastic-ips',
          attribute_values: [
            {
              attribute_value: '5'
            }
          ]
        },
        {
          attribute_name: 'default-vpc',
          attribute_values: [
            {
              attribute_value: 'none'
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
