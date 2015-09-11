Aws.config[:iam] = {
  stub_responses: {
    list_users: {
      users: [
        path: '/',
        user_name: 'my-iam-user',
        user_id: 'ABCDEFGHI1234556890',
        arn: 'arn:aws:iam::123456789012:user/my-iam-user',
        create_date: Time.local(2015)
      ]
    },
    list_groups_for_user: {
      groups: [
        {
          path: '/',
          group_name: 'my-iam-group',
          group_id: 'GABCDEFGHI123455689',
          arn: 'arn:aws:iam::123456789012:group/my-iam-group',
          create_date: Time.local(2015)
        }
      ]
    },
    list_attached_user_policies: {
      attached_policies: [
        {
          policy_arn: 'arn:aws:iam::aws:policy/ReadOnlyAccess',
          policy_name: 'ReadOnlyAccess'
        }
      ],
      is_truncated: false,
      marker: nil
    }
  }
}
