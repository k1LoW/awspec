Aws.config[:ec2] = {
  stub_responses: {
    describe_nat_gateways: {
      nat_gateways: [
        {
          nat_gateway_id: 'nat-7ff7777f',
          vpc_id: 'vpc-ab123cde',
          state: 'available',
          nat_gateway_addresses: [
            public_ip: '123.0.456.789',
            allocation_id: 'unknown',
            private_ip: 'unknown',
            network_interface_id: 'unknown'
          ],
          tags: [
            {
              key: 'Name',
              value: 'my-nat-gateway'
            }
          ]
        }
      ],
      next_token: nil
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
