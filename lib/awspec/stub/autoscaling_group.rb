# rubocop:disable Metrics/LineLength
Aws.config[:autoscaling] = {
  stub_responses: {
    describe_auto_scaling_groups: {
      auto_scaling_groups: [
        {
          auto_scaling_group_name: 'my-auto-scaling-group',
          auto_scaling_group_arn: 'arn:aws:autoscaling:::autoScalingGroup::autoScalingGroupName/my-auto-scaling-group',
          launch_configuration_name: 'my-lc',
          min_size: 4,
          max_size: 20,
          desired_capacity: 4,
          default_cooldown: 300,
          availability_zones: [
            'ap-northeast-1a',
            'ap-northeast-1c'
          ],
          load_balancer_names: [
            'my-elb'
          ],
          health_check_type: 'EC2',
          health_check_grace_period: 0,
          instances: [
            {
              instance_id: 'i-ec12345a',
              availability_zone: 'ap-northeast-1a',
              lifecycle_state: 'InService',
              health_status: 'Healthy',
              launch_configuration_name: 'my-lc',
              protected_from_scale_in: false
            }
          ],
          created_time: Time.local(2015),
          tags: [
            {
              key: 'Dept',
              propagate_at_launch: true,
              resource_id: 'my-auto-scaling-group',
              resource_type: 'auto-scaling-group',
              value: 'Research'
            },
            {
              key: 'Role',
              propagate_at_launch: true,
              resource_id: 'my-auto-scaling-group',
              resource_type: 'auto-scaling-group',
              value: 'WebServer'
            }
          ],
          suspended_processes: [
            {
              process_name: 'HealthCheck'
            }
          ]
        }
      ]
    },
    describe_tags: {
      tags: [
        {
          key: 'Dept',
          propagate_at_launch: true,
          resource_id: 'my-auto-scaling-group',
          resource_type: 'auto-scaling-group',
          value: 'Research'
        },
        {
          key: 'Role',
          propagate_at_launch: true,
          resource_id: 'my-auto-scaling-group',
          resource_type: 'auto-scaling-group',
          value: 'WebServer'
        }
      ]
    },
    describe_load_balancer_target_groups: {
      load_balancer_target_groups: [
        {
          load_balancer_target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067',
          state: 'Added'
        }
      ]
    }
  }
}

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
    describe_target_groups: {
      target_groups: [
        {
          health_check_interval_seconds: 30,
          health_check_path: '/',
          health_check_port: 'traffic-port',
          health_check_protocol: 'HTTP',
          health_check_timeout_seconds: 5,
          healthy_threshold_count: 5,
          load_balancer_arns: [
            'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-alb/1aa1bb1cc1ddee11'
          ],
          matcher: {
            http_code: '200'
          },
          port: 80,
          protocol: 'HTTP',
          target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067',
          target_group_name: 'my-alb-target-group',
          unhealthy_threshold_count: 2,
          vpc_id: 'vpc-ab123cde'
        }
      ]
    },
    describe_target_health: {
      target_health_descriptions: [
        {
          target: {
            id: 'i-0f76fade',
            port: 80
          },
          target_health: {
            description: 'Given target group is not configured to receive traffic from ELB',
            reason: 'Target.NotInUse',
            state: 'unused'
          }
        },
        {
          health_check_port: '80',
          target: {
            id: 'i-ec12345a',
            port: 80
          },
          target_health: {
            state: 'healthy'
          }
        }
      ]
    }
  }
}

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
    describe_subnets: {
      subnets: [
        {
          vpc_id: 'vpc-ab123cde',
          subnet_id: 'subnet-1234a567',
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
