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
