Aws.config[:ec2] = {
  stub_responses: {
    describe_security_groups: {
      security_groups: [
        {
          vpc_id: 'vpc-ab123cde',
          owner_id: '112233445566',
          group_id: 'sg-1a2b3cd4',
          group_name: 'my-security-group-name',
          tags: [
            {
              key: 'env',
              value: 'dev'
            }
          ],
          ip_permissions: [
            {
              from_port: 80,
              to_port: 80,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '123.45.67.0/24'
                },
                {
                  cidr_ip: '123.45.68.89/32'
                }
              ],
              user_id_group_pairs: []
            },
            {
              from_port: 22,
              to_port: 22,
              ip_protocol: 'tcp',
              ip_ranges: [],
              user_id_group_pairs: [
                {
                  group_id: 'sg-5a6b7cd8',
                  group_name: 'group-name-sg'
                }
              ]
            },
            {
              from_port: 60_000,
              to_port: 60_000,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '100.45.67.12/32'
                }
              ],
              user_id_group_pairs: []
            },
            {
              from_port: 70_000,
              to_port: 70_000,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '100.45.67.89/32'
                }
              ],
              user_id_group_pairs: []
            },
            {
              from_port: 70_000,
              to_port: 70_000,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '100.45.67.12/32'
                }
              ],
              user_id_group_pairs: []
            },
            {
              from_port: 50_000,
              to_port: 50_009,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '123.45.67.89/32'
                }
              ],
              user_id_group_pairs: []
            },
            {
              from_port: nil,
              to_port: nil,
              ip_protocol: '-1',
              ip_ranges: [],
              user_id_group_pairs: [
                {
                  user_id: '1234567890',
                  group_name: nil,
                  group_id: 'sg-3a4b5cd6',
                  vpc_id: nil,
                  vpc_peering_connection_id: nil,
                  peering_status: nil
                }
              ]
            }
          ],
          ip_permissions_egress: [
            {
              from_port: 50_000,
              to_port: 50_000,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '100.45.67.12/32'
                }
              ]
            },
            {
              from_port: 8080,
              to_port: 8080,
              ip_protocol: 'tcp',
              ip_ranges: [],
              user_id_group_pairs: [
                {
                  user_id: '5678901234',
                  group_name: 'group-in-other-aws-account-with-vpc-peering',
                  group_id: 'sg-9a8b7c6d',
                  vpc_id: 'vpc-5b6a7c8f',
                  vpc_peering_connection_id: 'pcx-f9e8d7c6',
                  peering_status: 'active'
                }
              ]
            },
            {
              from_port: 443,
              to_port: 443,
              ip_protocol: 'tcp',
              prefix_list_ids: [
                {
                  prefix_list_id: 'pl-a5321fa3'
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
