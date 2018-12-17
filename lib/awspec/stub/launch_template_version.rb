Aws.config[:ec2] = {
  stub_responses: {
    describe_launch_template_versions: {
      launch_template_versions: [
        {
          create_time: Time.parse('2017-11-20T12:52:33.000Z'),
          created_by: 'arn:aws:iam::123456789102:root',
          default_version: true,
          launch_template_data: {
            image_id: 'ami-aabbcc11',
            instance_type: 't2.medium',
            key_name: 'kp-us-east',
            network_interfaces: [
              {
                associate_public_ip_address: true,
                delete_on_termination: false,
                device_index: 0,
                groups: [
                  'sg-7c227019'
                ],
                subnet_id: 'subnet-7b16de0c'
              }
            ],
            user_data: ''
          },
          launch_template_id: 'lt-01238c059e3466abc',
          launch_template_name: 'my-launch-template',
          version_number: 1
        }
      ]
    }
  }
}
