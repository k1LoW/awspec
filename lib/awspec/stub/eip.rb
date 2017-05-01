Aws.config[:ec2] = {
  stub_responses: {
    describe_addresses: {
      addresses: [
        {
          domain: 'vpc',
          public_ip: '123.0.456.789',
          instance_id: 'i-ec12345a'
        }
      ]
    }
  }
}
