# frozen_string_literal: true

Aws.config[:ec2] = {
  stub_responses: {
    describe_managed_prefix_lists: {
      next_token: nil,
      prefix_lists: [
        {
          prefix_list_id: 'pl-12345678',
          address_family: 'IPv4',
          state: 'create-complete',
          state_message: nil,
          prefix_list_arn: 'arn:aws:ec2:ap-northeast-1:aws:prefix-list/pl-12345678',
          prefix_list_name: 'my-managed-prefix-list',
          max_entries: 2,
          version: 1,
          tags: [
            {
              key: 'env',
              value: 'dev'
            }
          ],
          owner_id: '123456789012'
        }
      ]
    },
    get_managed_prefix_list_entries: {
      next_toke: nil,
      entries: [
        {
          cidr: '10.0.0.0/16',
          description: 'test'
        },
        {
          cidr: '192.168.0.0/24',
          description: 'dev'
        }
      ]
    }
  }
}
