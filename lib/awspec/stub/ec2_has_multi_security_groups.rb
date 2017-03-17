require_relative '../stub/ec2'

stub_responses = Aws.config[:ec2][:stub_responses]

stub_responses[:describe_instances][:reservations][0][:instances][0][:security_groups] <<
  {
    group_id: 'sg-5e6f7gh8',
    group_name: 'my-security-group-name-2'
  }

stub_responses[:describe_security_groups][:security_groups] <<
  {
    group_id: 'sg-5e6f7gh8',
    group_name: 'my-security-group-name-2',
    tags: [
      {
        key: 'Name',
        value: 'my-security-group-tag-name-2'
      }
    ]
  }
