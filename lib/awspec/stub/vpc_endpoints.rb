Aws.config[:ec2] = {
  stub_responses: {
    describe_vpc_endpoints: {
      vpc_endpoints: [
        {
          vpc_endpoint_id: 'vpce-123456789abcdefgh',
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
        }
      ],
      next_token: nil
    }
  }
}
