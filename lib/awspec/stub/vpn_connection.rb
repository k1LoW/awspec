# rubocop:disable all
Aws.config[:ec2] = {
  stub_responses: {
    describe_vpn_connections: {
      vpn_connections: [
        {
          vpn_connection_id: 'vpn-cg5692g4',
          customer_gateway_id: 'cgw-cg5692g4',
          vpn_gateway_id: 'vgw-cg5692g4',
          state: 'available',
          type: "ipsec.1"
        }
      ]
    }
  }
}
