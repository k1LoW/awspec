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
