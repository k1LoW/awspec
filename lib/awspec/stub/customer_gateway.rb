# rubocop:disable all
Aws.config[:ec2] = {
  stub_responses: {
    describe_customer_gateways: {
      customer_gateways: [
        {
          customer_gateway_id: 'cgw-cg5692g4',
          ip_address: '1.1.1.1',
          state: 'available',
          type: "ipsec.1",
          bgp_asn: "65000"
        }
      ]
    }
  }
}
