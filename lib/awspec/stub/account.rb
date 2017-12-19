Aws.config[:ec2] = {
  stub_responses: {
    describe_account_attributes: {
      account_attributes: [
        {
          attribute_name: 'supported-platforms',
          attribute_values: [
            {
              attribute_value: 'EC2'
            },
            {
              attribute_value: 'VPC'
            }
          ]
        },
        {
          attribute_name: 'vpc-max-security-groups-per-interface',
          attribute_values: [
            {
              attribute_value: '5'
            }
          ]
        },
        {
          attribute_name: 'max-elastic-ips',
          attribute_values: [
            {
              attribute_value: '5'
            }
          ]
        },
        {
          attribute_name: 'max-instances',
          attribute_values: [
            {
              attribute_value: '20'
            }
          ]
        },
        {
          attribute_name: 'vpc-max-elastic-ips',
          attribute_values: [
            {
              attribute_value: '5'
            }
          ]
        },
        {
          attribute_name: 'default-vpc',
          attribute_values: [
            {
              attribute_value: 'none'
            }
          ]
        }
      ]
    }
  }
}
Aws.config[:rds] = {
  stub_responses: {
    describe_account_attributes: {
      account_quotas: [
        {
          account_quota_name: 'DBInstances', used: 0, max: 40
        },
        {
          account_quota_name: 'ReservedDBInstances', used: 0, max: 40
        },
        {
          account_quota_name: 'AllocatedStorage', used: 0, max: 100_000
        },
        {
          account_quota_name: 'DBSecurityGroups', used: 0, max: 25
        },
        {
          account_quota_name: 'AuthorizationsPerDBSecurityGroup', used: 0, max: 20
        },
        {
          account_quota_name: 'DBParameterGroups', used: 1, max: 50
        },
        {
          account_quota_name: 'ManualSnapshots', used: 0, max: 100
        },
        {
          account_quota_name: 'EventSubscriptions', used: 0, max: 20
        },
        {
          account_quota_name: 'DBSubnetGroups', used: 1, max: 50
        },
        {
          account_quota_name: 'OptionGroups', used: 0, max: 20
        },
        {
          account_quota_name: 'SubnetsPerDBSubnetGroup', used: 2, max: 20
        },
        {
          account_quota_name: 'ReadReplicasPerMaster', used: 0, max: 5
        },
        {
          account_quota_name: 'DBClusters', used: 0, max: 40
        },
        {
          account_quota_name: 'DBClusterParameterGroups', used: 0, max: 50
        },
        {
          account_quota_name: 'DBClusterRoles', used: 0, max: 5
        }
      ]
    }
  }
}
Aws.config[:lambda] = {
  stub_responses: {
    get_account_settings: {
      account_limit: {
        total_code_size: 80_530_636_800,
        code_size_unzipped: 262_144_000,
        code_size_zipped: 52_428_800,
        concurrent_executions: 200,
        unreserved_concurrent_executions: 50
      },
      account_usage: {
        total_code_size: 2_034_651_562,
        function_count: 8
      }
    }
  }
}
Aws.config[:ses] = {
  stub_responses: {
    get_send_quota: {
      max_24_hour_send: 200.0,
      max_send_rate: 1.0,
      sent_last_24_hours: 1.0
    }
  }
}
Aws.config[:sts] = {
  stub_responses: {
    get_caller_identity: {
      account: '123456789012',
      arn: 'arn:aws:iam::123456789012:user/Alice',
      user_id: 'AKIAI44QH8DHBEXAMPLE'
    }
  }
}
