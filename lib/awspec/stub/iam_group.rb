Aws.config[:iam] = {
  stub_responses: {
    list_users: {
      users: [
        path: '/',
        user_name: 'my-iam-user',
        user_id: 'ABCDEFGHI1234556890',
        arn: 'arn:aws:iam::123456789012:user/my-iam-user',
        create_date: Time.new(2015, 1, 2, 10, 00, 00, '+00:00')
      ]
    },
    list_groups: {
      groups: [
        path: '/',
        group_name: 'my-iam-group',
        group_id: 'GABCDEFGHI123455689',
        arn: 'arn:aws:iam::123456789012:group/my-iam-group',
        create_date: Time.new(2015, 1, 2, 11, 00, 00, '+00:00')
      ]
    },
    list_groups_for_user: {
      groups: [
        {
          path: '/',
          group_name: 'my-iam-group',
          group_id: 'GABCDEFGHI123455689',
          arn: 'arn:aws:iam::123456789012:group/my-iam-group',
          create_date: Time.new(2015, 1, 2, 12, 00, 00, '+00:00')
        }
      ]
    },
    list_attached_group_policies: {
      attached_policies: [
        {
          policy_arn: 'arn:aws:iam::aws:policy/ReadOnlyAccess',
          policy_name: 'ReadOnlyAccess'
        }
      ],
      is_truncated: false,
      marker: nil
    },
    list_group_policies: {
      policy_names: [
        'InlineEC2FullAccess'
      ],
      is_truncated: false,
      marker: nil
    },
    get_group: {
      group: {
        path: '/',
        group_name: 'my-iam-group',
        group_id: 'GABCDEFGHI123455689',
        arn: 'arn:aws:iam::123456789012:group/my-iam-group',
        create_date: Time.new(2015, 1, 2, 10, 00, 00, '+00:00')
      },
      users: [
        {
          path: '/',
          user_name: 'my-iam-user',
          user_id: 'ABCDEFGHI1234556890',
          arn: 'arn:aws:iam::123456789012:user/my-iam-user',
          create_date: Time.new(2015, 1, 2, 10, 00, 00, '+00:00')
        }
      ]
    },
    get_group_policy: {
      group_name: 'my-iam-group',
      policy_name: 'InlineEC2FullAccess',
      policy_document: '{"Statement": [{"Action": "ec2:*","Effect": "Allow",' \
                       '"Resource": "*"},{"Effect": "Allow","Action": "elasticloadbalancing:*",' \
                       '"Resource": "*"},{"Effect": "Allow","Action": "cloudwatch:*",' \
                       '"Resource": "*"},{"Effect": "Allow","Action": "autoscaling:*",' \
                       '"Resource": "*"}]}'
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
