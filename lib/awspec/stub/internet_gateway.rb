Aws.config[:ec2] = {
  stub_responses: {
    describe_internet_gateways: {
      internet_gateways: [
        internet_gateway_id: 'igw-1ab2cd3e',
        attachments: [
          {
            vpc_id: 'vpc-ab123cde',
            state: 'attached'
          }
        ],
        tags: [
          {
            key: 'Name',
            value: 'my-internet-gateway'
          }
        ]
      ]
    }
  }
}
