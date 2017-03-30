Aws.config[:ec2] = {
  stub_responses: {
    describe_internet_gateways: {
      internet_gateways: [
        internet_gateway_id: 'igw-1ab2cd3e',
        attachments: [
          {
            vpc_id: 'vpc-ab123cde',
            state: 'available'
          }
        ],
        tags: [
          {
            key: 'Name',
            value: 'my-internet-gateway'
          }
        ]
      ]
    },
    describe_vpcs: {
      vpcs: [
        {
          vpc_id: 'vpc-ab123cde',
          state: 'available',
          cidr_block: '10.0.0.0/16',
          tags: [
            {
              key: 'Name',
              value: 'my-vpc'
            }
          ]
        }
      ]
    }
  }
}
