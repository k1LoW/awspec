Aws.config[:ec2] = {
  stub_responses: {
    describe_security_groups: {
      security_groups: [
        {
          vpc_id: 'vpc-ab123cde',
          group_id: 'sg-1a2b3cd4',
          group_name: 'my-security-group-name',
          ip_permissions: [
            {
              from_port: 80,
              to_port: 80,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '123.456.789.012/32'
                },
                {
                  cidr_ip: '456.789.123.456/32'
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
                  cidr_ip: '100.456.789.012/32'
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
                  cidr_ip: '100.456.789.012/32'
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
                  cidr_ip: '101.456.789.012/32'
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
                  cidr_ip: '123.456.789.012/32'
                }
              ],
              user_id_group_pairs: []
            }
          ],
          ip_permissions_egress: [
            {
              from_port: 50_000,
              to_port: 50_000,
              ip_protocol: 'tcp',
              ip_ranges: [
                {
                  cidr_ip: '100.456.789.012/32'
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
