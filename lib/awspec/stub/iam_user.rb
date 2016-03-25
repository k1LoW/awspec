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
    },
    get_user_policy: {
      user_name: 'my-iam-user',
      policy_name: 'AllowS3BucketAccess',
      policy_document: '{"Statement": [{"Action": ["s3:ListAllMyBuckets"],' \
                       '"Effect": "Allow","Resource": "arn:aws:s3:::*"},' \
                       '{"Action": "s3:*","Effect": "Allow","Resource":' \
                       '["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]}]}'
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
