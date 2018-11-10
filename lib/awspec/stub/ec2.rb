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
              iam_instance_profile: {
                arn: 'arn:aws:iam::123456789012:instance-profile/Ec2IamProfileName',
                id: 'ABCDEFGHIJKLMNOPQRSTU'
              },
              block_device_mappings: [
                {
                  device_name: '/dev/sda',
                  ebs: {
                    volume_id: 'vol-123a123b'
                  }
                }
              ],
              network_interfaces: [
                {
                  network_interface_id: 'eni-12ab3cde',
                  subnet_id: 'subnet-1234a567',
                  vpc_id: 'vpc-ab123cde',
                  attachment: {
                    device_index: 1
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
      instances: [
        instance_id: 'my-ec2-classic',
        vpc_id: 'my-vpc',
        groups: [
          { group_name: nil, group_id: 'sg-2a3b4cd5' },
          { group_name: 'my-vpc-security-group-name', group_id: nil }
        ]
      ]
    },
    describe_network_interfaces: {
      network_interfaces: [
        {
          network_interface_id: 'eni-12ab3cde',
          subnet_id: 'subnet-1234a567',
          vpc_id: 'vpc-ab123cde',
          availability_zone: 'ap-northeast-1c',
          description: '',
          owner_id: '1234567890',
          requester_id: nil,
          requester_managed: false,
          status: 'in-use',
          mac_address: '00:11:aa:bb:cc:22',
          private_ip_address: '10.0.1.1',
          private_dns_name: nil,
          source_dest_check: true,
          groups:
            [
              {
                group_name: 'my-security-group-name',
                group_id: 'sg-1a2b3cd4'
              }
            ],
          attachment: {
            attachment_id: 'eni-attach-12ab3cde',
            instance_id: 'i-ec12345a',
            instance_owner_id: '1234567890',
            device_index: 0,
            status: 'attached',
            attach_time: nil,
            delete_on_termination: true
          },
          association: nil,
          tag_set: [
            {
              key: 'Name',
              value: 'my-eni'
            }
          ],
          private_ip_addresses: [
            {
              private_ip_address: '10.0.1.1',
              private_dns_name: nil,
              primary: true,
              association: nil
            },
            {
              private_ip_address: '10.0.1.2',
              private_dns_name: '',
              primary: false,
              association: nil
            }
          ],
          interface_type: nil
        }
      ]
    },
    describe_instance_credit_specifications: {
      instance_credit_specifications: [
        {
          instance_id: 'i-ec12345a',
          cpu_credits: 'unlimited'
        }
      ]
    }
  }
}
