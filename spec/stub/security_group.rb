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
                  group_id: 'sg-5a6b7cd8'
                }
              ]
            }
          ],
          ip_permissions_egress: [
            {
              from_port: nil,
              to_port: nil,
              ip_protocol: '-1',
              ip_ranges: [
                {
                  cidr_ip: '0.0.0.0/0'
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
