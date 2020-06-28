Aws.config[:ec2] = {
  stub_responses: {
    describe_transit_gateways: {
      transit_gateways: [
        {
          transit_gateway_id: 'tgw-1234567890abcdefg',
          transit_gateway_arn: 'arn:aws:ec2:us-east-2:123456789012:transit-gateway/tgw-1234567890abcdefg',
          owner_id: '123456789012',
          options: {
            amazon_side_asn: 64_516,
            auto_accept_shared_attachments: 'enable',
            default_route_table_association: 'enable',
            default_route_table_propagation: 'enable',
            dns_support: 'enable',
            vpn_ecmp_support: 'enable',
            association_default_route_table_id: 'tgw-rtb-0123456789abcdefg',
            propagation_default_route_table_id: 'tgw-rtb-0123456789abcdefg'
          },
          tags: [
            {
              key: 'Name',
              value: 'my-transit-gateway'
            }
          ]
        }
      ]
    },
    describe_transit_gateway_attachments: {
      transit_gateway_attachments: [
        {
          transit_gateway_attachment_id: 'tgw-attach-1234567890abcdefg',
          transit_gateway_id: 'tgw-1234567890abcdefg',
          transit_gateway_owner_id: '123456789012',
          resource_owner_id: '123456789012',
          resource_type: 'vpc',
          resource_id: 'vpc-12345678',
          state: 'available',
          association: {
            transit_gateway_route_table_id: 'tgw-rtb-0123456789abcdefg',
            state: 'associated'
          },
          tags: [
            {
              key: 'Name',
              value: 'my-transit-gateway-attachment'
            }
          ]
        }
      ]
    }
  }
}
