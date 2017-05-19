Aws.config[:autoscaling] = {
  stub_responses: {
    describe_launch_configurations: {
      launch_configurations: [
        launch_configuration_name: 'my-lc',
        launch_configuration_arn:
          'arn:aws:autoscaling:ap-northeast-1:123456789012:launchConfiguration:\
1a11111b-22f2-3e33-444-55cf55e55555:launchConfigurationName/my-lc',
        image_id: 'ami-abc12def',
        key_name: 'my_key_pair',
        security_groups: ['sg-1a2b3cd4'],
        classic_link_vpc_id: nil,
        classic_link_vpc_security_groups: [],
        user_data: '',
        instance_type: 'c3.large',
        kernel_id: '',
        ramdisk_id: '',
        block_device_mappings: [
          {
            virtual_name: 'ephemeral0',
            device_name: '/dev/sdf'
          }
        ],
        instance_monitoring: {
          enabled: true
        },
        spot_price: nil,
        iam_instance_profile: nil,
        created_time: Time.local(2015),
        ebs_optimized: false,
        associate_public_ip_address: true,
        placement_tenancy: nil
      ],
      next_token: nil
    }
  }
}

Aws.config[:ec2] = {
  stub_responses: {
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
