# frozen_string_literal: true

Aws.config[:iam] = {
  stub_responses: {
    list_roles: {
      roles: [
        path: '/',
        role_name: 'my-iam-role',
        role_id: 'RABCDEFGHI123455689',
        arn: 'arn:aws:iam::123456789012:role/my-iam-role',
        description: 'my-description',
        create_date: Time.new(2015, 1, 2, 9, 00, 00, '+00:00')
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
    list_role_policies: {
      policy_names: [
        'AllowS3BucketAccess'
      ],
      is_truncated: false,
      marker: nil
    },
    get_role: {
      role: {
        path: '/',
        role_name: 'my-iam-role',
        role_id: 'RABCDEFGHI123455689',
        arn: 'arn:aws:iam::123456789012:role/my-iam-role',
        description: 'my-description',
        create_date: Time.new(2015, 1, 2, 9, 00, 00, '+00:00'),
        permissions_boundary: {
          permissions_boundary_type: 'Policy',
          permissions_boundary_arn: 'arn:aws:iam::123456789012:policy/my-permission-boundary'
        },
        role_last_used: {
          region: 'us-east-1',
          last_used_date: Time.new(2019, 11, 13, 17, 14, 00, '+00:00')
        }
      }
    },
    get_role_policy: {
      role_name: 'my-iam-role',
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
          matched_statements: []
        }
      ],
      is_truncated: false,
      marker: nil
    }
  }
}
