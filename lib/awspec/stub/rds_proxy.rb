# frozen_string_literal: true

Aws.config[:rds] = {
  stub_responses: {
    describe_db_proxies: {
      db_proxies: [
        {
          db_proxy_name: 'my-rds-proxy',
          db_proxy_arn: 'arn:aws:rds:ap-northeast-1:123456789012:db-proxy:my-rds-proxy',
          status: 'available',
          engine_family: 'MYSQL',
          vpc_id: 'vpc-ab123cde',
          vpc_security_group_ids: [
            'sg-5a6b7cd8'
          ],
          vpc_subnet_ids: [
            'subnet-8901b123'
          ],
          auth: [
            {
              description: nil,
              user_name: nil,
              auth_scheme: 'SECRETS',
              secret_arn: 'arn:aws:secretsmanager:ap-northeast-1:123456789012:secret:mysql-FShJ8c',
              iam_auth: 'DISABLED'
            }
          ],
          role_arn: 'arn:aws:iam::123456789012:role/service-role/rds-proxy-role-123456789012',
          endpoint: 'rds-proxy.proxy-abcdefghij12.ap-northeast-1.rds.amazonaws.com',
          require_tls: true,
          idle_client_timeout: 5400,
          debug_logging: false,
          created_date: Time.local(2022),
          updated_date: Time.local(2022)
        }
      ],
      marker: nil
    }
  }
}

Aws.config[:ec2] = {
  stub_responses: {
    describe_vpcs: {
      vpcs: [
        {
          vpc_id: 'vpc-ab123cde',
          tags: [
            {
              key: 'Name',
              value: 'my-vpc'
            }
          ]
        }
      ]
    },
    describe_security_groups: {
      security_groups: [
        {
          group_id: 'sg-5a6b7cd8',
          group_name: 'group-name-sg',
          tags: [
            {
              key: 'Name',
              value: 'my-db-sg'
            }
          ]
        }
      ]
    },
    describe_subnets: {
      subnets: [
        {
          subnet_id: 'subnet-8901b123',
          tags: [
            {
              key: 'Name',
              value: 'db-subnet-a'
            }
          ]
        }
      ]
    }
  }
}
