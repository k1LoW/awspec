Aws.config[:ec2] = {
  stub_responses: {
    describe_vpc_endpoints: {
      vpc_endpoints: [
        {
          vpc_endpoint_id: 'vpce-abc123',
          vpc_endpoint_type: 'Gateway',
          vpc_id: 'vpc-12345678',
          service_name: 'com.amazonaws.us-east-1.s3',
          state: 'available',
          policy_document: '{"Version": "2008-10-17", "Statement": [{' \
                           '"Effect": "Allow", "Principal": "*", "Action": "*",' \
                           '"Resource": "*"}]}',
          route_table_ids: ['rtb-0123456789abcdefg'],
          subnet_ids: [],
          groups: [],
          private_dns_enabled: false,
          requester_managed: false,
          network_interface_ids: [],
          dns_entries: [],
          creation_timestamp: Time.new(2020, 8, 13, 9, 00, 00, '+00:00'),
          tags: [
            {
              key: 'Name',
              value: 'my_vpc_endpoint'
            }
          ],
          owner_id: '112233445566'
        },
        {
          vpc_endpoint_id: 'vpce-abc124',
          vpc_endpoint_type: 'Interface',
          vpc_id: 'vpc-12345678',
          service_name: 'com.amazonaws.eu-west-1.codebuild',
          state: 'available',
          policy_document: '{"Version": "2008-10-17", "Statement": [{' \
                           '"Effect": "Allow", "Principal": "*", "Action": "*",' \
                           '"Resource": "*"}]}',
          route_table_ids: [],
          subnet_ids: ['subnet-abc123'],
          groups: [{ group_id: 'sg-abc123', group_name: 'default' }],
          private_dns_enabled: true,
          requester_managed: false,
          network_interface_ids: ['eni-06f28a949cb88b84c'],
          dns_entries: [
            {
              dns_name: 'vpce-05907f23265b25f20-wwafshom.codebuild.eu-west-1.vpce.amazonaws.com',
              hosted_zone_id: 'Z38GZ743OKFT7T'
            }
          ],
          creation_timestamp: Time.new(2020, 8, 13, 9, 00, 00, '+00:00'),
          tags: [
            {
              key: 'Name',
              value: 'my_vpc_endpoint'
            }
          ],
          owner_id: '112233445566'
        }
      ],
      next_token: nil
    }
  }
}
