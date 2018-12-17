Aws.config[:ec2] = {
  stub_responses: {
    describe_launch_templates: {
      launch_templates: [
        {
          create_time: Time.parse('2018-01-16T04:32:57.000Z'),
          created_by: 'arn:aws:iam::123456789012:root',
          default_version_number: 1,
          latest_version_number: 2,
          launch_template_id: 'lt-01238c059e3466abc',
          launch_template_name: 'my-launch-template'
        }
      ]
    }
  }
}
