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
    describe_instance_attribute: {
      instance_id: 'i-ec12345a',
      disable_api_termination: {
        value: true
      }
    },
    describe_instance_status: {
      instance_statuses: [
        {
          instance_id: 'i-ec12345a',
          availability_zone: 'ap-northeast-1c',
          events: [
            {
              code: 'system-reboot',
              description: 'scheduled reboot'
            }
          ],
          instance_state: {
            name: 'running'
          },
          system_status: {
            status: 'ok'
          },
          instance_status: {
            status: 'ok'
          }
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
    },
    describe_addresses: {
      addresses: [
        {
          public_ip: '123.0.456.789',
          instance_id: 'i-ec12345a'
        }
      ]
    },
    describe_security_groups: {
      security_groups: [
        {
          group_id: 'sg-1a2b3cd4',
          group_name: 'my-security-group-name',
          tags: [
            {
              key: 'Name',
              value: 'my-security-group-tag-name'
            }
          ]
        }
      ]
    },
    describe_volumes: {
      volumes: [
        {
          volume_id: 'vpc-ab123cde',
          state: 'in-use',
          size: 100,
          attachments: [
            {
              instance_id: 'i-ec12345a',
              volume_id: 'vpc-ab123cde',
              state: 'attached'
            }
          ],
          tags: [
            {
              key: 'Name',
              value: 'my-volume'
            }
          ]
        }
      ]
    },
    describe_classic_link_instances: {
      instances:[
        instance_id: 'my-ec2-classic',
        vpc_id: 'my-vpc'
      ]
    }
  }
}
