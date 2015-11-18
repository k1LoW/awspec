Aws.config[:directconnect] = {
  stub_responses: {
    describe_virtual_interfaces: {
      virtual_interfaces: [
        {
          owner_account: '123456789012',
          virtual_interface_id: 'dxvif-aabbccdd',
          location: 'AbCD5',
          connection_id: 'dxcon-abcd5fgh',
          virtual_interface_type: 'private',
          virtual_interface_name: 'my-directconnect-virtual-interface',
          vlan: 400,
          asn: 65_007,
          auth_key: nil,
          amazon_address: '170.252.252.1/30',
          customer_address: '123.456.789.2/30',
          virtual_interface_state: 'available',
          customer_router_config: nil,
          virtual_gateway_id: 'vgw-d234e5f6',
          route_filter_prefixes: []
        }
      ]
    }
  }
}
