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
      marker: nil
    },
    simulate_principal_policy: {
      evaluation_results: [
        {
          eval_action_name: 'ec2:DescribeInstances',
          eval_resource_name: '*',
          eval_decision: 'allowed',
          matched_statements: [
          ]
        }
      ],
      is_truncated: false,
      marker: nil
    }
  }
}
