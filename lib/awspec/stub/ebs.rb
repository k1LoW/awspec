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
    describe_volumes: {
      volumes: [
        {
          volume_id: 'vpc-ab123cde',
          state: 'in-use',
          size: 100,
          volume_type: 'gp2',
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
    }
  }
}
