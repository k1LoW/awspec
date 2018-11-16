Aws.config[:elasticloadbalancing] = {
  stub_responses: {
    describe_load_balancers: {
      load_balancer_descriptions: [
        {
          load_balancer_name: 'my-elb',
          subnets: [
            'subnet-1234a567'
          ],
          instances: [
            {
              instance_id: 'i-ec12345a'
            }
          ],
          health_check: {
            target: 'HTTP:80/index.php',
            interval: 60,
            timeout: 5,
            unhealthy_threshold: 10,
            healthy_threshold: 2
          },
          security_groups: [
            'sg-5a2b3cd4'
          ],
          policies: {},
          source_security_group: {},
          listener_descriptions: [
            {
              listener: {
                protocol: 'HTTPS',
                load_balancer_port: 443,
                instance_protocol: 'HTTP',
                instance_port: 80
              }
            }
          ],
          vpc_id: 'vpc-ab123cde'
        }
      ]
    },
    describe_tags: {
      tag_descriptions: [
        {
          load_balancer_name: 'my-elb',
          tags: [
            {
              key: 'Name',
              value: 'my-elb'
            },
            {
              key: 'my-tag-key',
              value: 'my-tag-value'
            }
          ]
        }
      ]
    },
    describe_load_balancer_attributes: {
      load_balancer_attributes: {
        access_log: {
          enabled: true,
          s3_bucket_name: 'my-loadbalancer-logs',
          s3_bucket_prefix: 'my-app',
          emit_interval: 5
        },
        connection_draining: {
          enabled: false,
          timeout: 300
        },
        connection_settings: {
          idle_timeout: 60
        },
        cross_zone_load_balancing: {
          enabled: false
        }
      }
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
    describe_security_groups: {
      security_groups: [
        {
          group_id: 'sg-5a2b3cd4',
          group_name: 'my-lb-security-group-name',
          tags: [
            {
              key: 'Name',
              value: 'my-lb-security-group-tag-name'
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
