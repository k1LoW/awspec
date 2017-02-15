Aws.config[:ec2] = {
  stub_responses: {
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
            device_index: 1,
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
    }
  }
}
