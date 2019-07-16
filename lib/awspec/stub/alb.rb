# rubocop:disable Metrics/LineLength
Aws.config[:elasticloadbalancingv2] = {
  stub_responses: {
    describe_load_balancers: {
      load_balancers: [
        {
          load_balancer_arn:
            'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-alb/1aa1bb1cc1ddee11',
          dns_name:
            'internal-my-elb-1551266724.ap-northeast-1.elb.amazonaws.com',
          canonical_hosted_zone_id: 'A12BCDEDCBA34BC',
          created_time: Time.new(2017, 4, 4, 9, 00, 00, '+00:00'),
          load_balancer_name: 'my-alb',
          scheme: 'internal',
          vpc_id: 'vpc-ab123cde',
          state:
            {
              code: 'active',
              reason: nil
            },
          type: 'application',
          availability_zones:
            [
              {
                zone_name: 'ap-northeast-1a',
                subnet_id: 'subnet-1234a567'
              },
              {
                zone_name: 'ap-northeast-1c',
                subnet_id: 'subnet-abcd7890'
              }
            ],
          security_groups: ['sg-1a2b3cd4'],
          ip_address_type: 'ipv4'
        },
        {
          load_balancer_arn:
            'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/net/my-nlb/2aa2bb2cc2ddee22',
          dns_name:
            'my-nlb-2aa2bb2cc2ddee22.elb.ap-northeast-1.amazonaws.com',
          canonical_hosted_zone_id: 'N12BCDEDCBN34BC',
          created_time: Time.new(2017, 4, 4, 9, 00, 00, '+00:00'),
          load_balancer_name: 'my-nlb',
          scheme: 'internet-facing',
          vpc_id: 'vpc-ab123cde',
          state:
            {
              code: 'active',
              reason: nil
            },
          type: 'network',
          availability_zones:
            [
              {
                zone_name: 'ap-northeast-1a',
                subnet_id: 'subnet-7890ne12'
              },
              {
                zone_name: 'ap-northeast-1c',
                subnet_id: 'subnet-nnnd1234'
              }
            ],
          security_groups: ['sg-5n6b7c89'],
          ip_address_type: 'ipv4'
        }
      ],
      next_marker: nil
    },
    describe_listeners: {
      listeners: [
        {
          default_actions: [
            {
              target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:targetgroup/my-targets/73e2d6bc24d8a067',
              type: 'forward'
            }
          ],
          listener_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2',
          load_balancer_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-alb/1aa1bb1cc1ddee11',
          port: 80,
          protocol: 'HTTP'
        }
      ]
    },
    describe_tags: {
      tag_descriptions: [
        resource_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-alb/1aa1bb1cc1ddee11',
        tags: [
          key: 'environment',
          value: 'dev'
        ]
      ]
    }
  }
}

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
                  cidr_ip: '100.456.789.012/32'
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
