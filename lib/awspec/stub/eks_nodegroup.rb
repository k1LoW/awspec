# frozen_string_literal: true

Aws.config[:eks] = {
  stub_responses: {
    describe_nodegroup: {
      nodegroup: {
        version: '1.17',
        release_version: '1.17.12-20210322',
        cluster_name: 'my-cluster',
        nodegroup_name: 'my-nodegroup',
        nodegroup_arn: 'arn:aws:eks:us-west-2:012345678910:nodegroup/my-cluster/my-nodegroup/08bd000a',
        created_at: Time.parse('2018-10-28 00:23:32 -0400'),
        node_role: 'arn:aws:iam::012345678910:role/eks-nodegroup-role',
        status: 'ACTIVE',
        scaling_config: { min_size: 1, desired_size: 2, max_size: 3 }
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
    }
  }
}
