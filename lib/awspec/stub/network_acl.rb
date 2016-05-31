Aws.config[:ec2] = {
  stub_responses: {
    describe_network_acls: {
      network_acls: [
        {
          network_acl_id: 'acl-1abc2d3e',
          vpc_id: 'vpc-ab123cde',
          is_default: true,
          entries:
            [
              {
                rule_number:  100,
                protocol: '-1',
                rule_action: 'allow',
                egress:  true,
                cidr_block: '0.0.0.0/0'
              },
              {
                rule_number:  32_767,
                protocol: '-1',
                rule_action: 'deny',
                egress:  true,
                cidr_block: '0.0.0.0/0'
              },
              {
                rule_number:  2,
                protocol: '6',
                rule_action: 'allow',
                egress:  false,
                cidr_block: '123.0.456.789/32',
                port_range: {
                  from: 80, to: 80
                }
              },
              {
                rule_number: 100,
                protocol: '-1',
                rule_action: 'allow',
                egress: false,
                cidr_block: '0.0.0.0/0'
              },
              {
                rule_number: 32_767,
                protocol: '-1',
                rule_action: 'deny',
                egress: false,
                cidr_block: '0.0.0.0/0'
              }
            ],
          associations:
            [
              {
                network_acl_association_id: 'aclassoc-12345678',
                network_acl_id: 'acl-1abc2d3e',
                subnet_id: 'subnet-1234a567'
              }
            ],
          tags: [
            {
              key: 'Name',
              value: 'my-network-acl'
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
    }
  }
}
