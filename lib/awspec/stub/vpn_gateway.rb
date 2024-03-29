# rubocop:disable all
Aws.config[:ec2] = {
  stub_responses: {
    describe_vpn_gateways: {
      vpn_gateways: [
        {
          vpn_gateway_id: 'vgw-cg5692g4',
          availability_zone: 'us-east-1a',
          state: 'available',
          type: "ipsec.1",
          vpc_attachments: [
            {
              state: 'attached',
              vpc_id: 'vpc-ab123cde'
            }
          ],
          amazon_side_asn: 64512,
          tags: [
            {
              key: 'Name',
              value: 'my-vpn-gateway'
            }
          ]
        }
      ]
    }
  }
}
