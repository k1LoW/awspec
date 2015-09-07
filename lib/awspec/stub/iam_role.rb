Aws.config[:iam] = {
  stub_responses: {
    list_roles: {
      roles: [
        path: '/',
        role_name: 'my-iam-role',
        role_id: 'RABCDEFGHI123455689',
        arn: 'arn:aws:iam::123456789012:role/my-iam-role',
        create_date: Time.local(2015)
      ]
    },
    list_attached_role_policies: {
      attached_policies: [
        {
          policy_arn: 'arn:aws:iam::aws:policy/ReadOnlyAccess',
          policy_name: 'ReadOnlyAccess'
        }
      ],
      is_truncated: false,
      maker: nil
    }
  }
}
