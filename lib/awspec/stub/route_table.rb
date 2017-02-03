Aws.config[:ec2] = {
  stub_responses: {
    describe_instances: {
      reservations: [
        {
          instances: [
            {
              instance_id: 'i-ec12345a',
              image_id: 'ami-abc12def',
              vpc_id: 'vpc-ab123cde',
              subnet_id: 'subnet-1234a567',
              public_ip_address: '123.0.456.789',
              private_ip_address: '10.0.1.1',
              instance_type: 't2.small',
              state: {
                name: 'running'
              },
              security_groups: [
                {
                  group_id: 'sg-1a2b3cd4',
                  group_name: 'my-security-group-name'
                }
              ],
              block_device_mappings: [
                {
                  device_name: '/dev/sda',
                  ebs: {
                    volume_id: 'vol-123a123b'
                  }
                }
              ],
              tags: [
                {
                  key: 'Name',
                  value: 'my-ec2'
                }
              ]
            }
          ]
        }
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
    },
    describe_route_tables: {
      route_tables: [
        {
          route_table_id: 'rtb-a12bcd34',
          vpc_id: 'vpc-ab123cde',
          routes: [
            {
              destination_cidr_block: '10.0.0.0/16',
              destination_prefix_list_id: nil,
              gateway_id: 'local',
              instance_id: nil,
              instance_owner_id: nil,
              nat_gateway_id: nil,
              network_interface_id: nil,
              vpc_peering_connection_id: nil,
              state: 'active'
            },
            {
              destination_cidr_block: '0.0.0.0/0',
              destination_prefix_list_id: nil,
              gateway_id: 'igw-1ab2345c',
              instance_id: nil,
              instance_owner_id: nil,
              nat_gateway_id: nil,
              network_interface_id: nil,
              vpc_peering_connection_id: nil,
              state: 'active'
            },
            {
              destination_cidr_block: '192.168.1.0/24',
              destination_prefix_list_id: nil,
              gateway_id: nil,
              instance_id: 'i-ec12345a',
              instance_owner_id: nil,
              nat_gateway_id: nil,
              network_interface_id: nil,
              vpc_peering_connection_id: nil,
              state: 'active'
            },
            {
              destination_cidr_block: '192.168.2.0/24',
              destination_prefix_list_id: nil,
              gateway_id: nil,
              instance_id: nil,
              instance_owner_id: nil,
              nat_gateway_id: nil,
              network_interface_id: nil,
              vpc_peering_connection_id: 'pcx-c56789de',
              state: 'active'
            },
            {
              destination_cidr_block: '192.168.3.0/24',
              destination_prefix_list_id: nil,
              gateway_id: nil,
              instance_id: nil,
              instance_owner_id: nil,
              nat_gateway_id: 'nat-7ff7777f',
              network_interface_id: nil,
              vpc_peering_connection_id: nil,
              state: 'active'
            },
            {
              destination_cidr_block: nil,
              destination_prefix_list_id: 'pl-1a2b3c4d',
              gateway_id: 'vpce-11bb22cc',
              instance_id: nil,
              instance_owner_id: nil,
              nat_gateway_id: nil,
              network_interface_id: nil,
              vpc_peering_connection_id: nil,
              state: 'active'
            }
          ],
          associations: [
            {
              route_table_association_id: 'rtbassoc-b123456cd',
              route_table_id: 'rtb-a12bcd34',
              subnet_id: 'subnet-1234a567',
              main: false
            }
          ],
          tags: [
            {
              key: 'Name',
              value: 'my-route-table'
            }
          ]
        }
      ]
    },
    describe_subnets: {
      subnets: [
        {
          state: 'available',
          vpc_id: 'vpc-ab123cde',
          subnet_id: 'subnet-1234a567',
          cidr_block: '10.0.1.0/24',
          tags: [
            {
              key: 'Name',
              value: 'my-subnet'
            }
          ]
        }
      ]
    },
    describe_internet_gateways: {
      internet_gateways: [
        {
          internet_gateway_id: 'igw-1ab2345c',
          attachments:
            [
              {
                vpc_id: 'vpc-ab123cde',
                state: 'available'
              }
            ],
          tags: [
            {
              key: 'Name',
              value: 'my-igw'
            }
          ]
        }
      ]
    },
    describe_nat_gateways: {
      nat_gateways: [
        {
          nat_gateway_id: 'nat-7ff7777f',
          vpc_id: 'vpc-ab123cde',
          state: 'available'
        }
      ]
    },
    describe_vpc_peering_connections: {
      vpc_peering_connections: [
        {
          vpc_peering_connection_id: 'pcx-c56789de',
          tags: [
            {
              key: 'Name',
              value: 'my-pcx'
            }
          ]
        }
      ]
    }
  }
}
