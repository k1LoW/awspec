# rubocop:disable Metrics/LineLength
Aws.config[:elasticloadbalancingv2] = {
  stub_responses: {
    describe_load_balancers: {
      load_balancers: [
        {
          load_balancer_arn:
            'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-nlb/1aa1bb1cc1ddee11',
          dns_name:
            'internal-my-nlb-1551266724.ap-northeast-1.elb.amazonaws.com',
          canonical_hosted_zone_id: 'A12BCDEDCBA34BC',
          created_time: Time.new(2017, 4, 4, 9, 00, 00, '+00:00'),
          load_balancer_name: 'my-nlb',
          # scheme: 'internal',
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
                subnet_id: 'subnet-1234a567'
              },
              {
                zone_name: 'ap-northeast-1c',
                subnet_id: 'subnet-abcd7890'
              }
            ],
          ip_address_type: 'ipv4'
        },
        {
          load_balancer_arn:
            'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/net/my-alb/2aa2bb2cc2ddee22',
          dns_name:
            'my-alb-2aa2bb2cc2ddee22.elb.ap-northeast-1.amazonaws.com',
          canonical_hosted_zone_id: 'N12BCDEDCBN34BC',
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
                subnet_id: 'subnet-7890ne12'
              },
              {
                zone_name: 'ap-northeast-1c',
                subnet_id: 'subnet-nnnd1234'
              }
            ],
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
          listener_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2',
          load_balancer_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-nlb/1aa1bb1cc1ddee11',
          port: 80,
          protocol: 'HTTP'
        }
      ]
    }
  }
}

Aws.config[:ec2] = {
  stub_responses: {
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
