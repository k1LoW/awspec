Aws.config[:rds] = {
  stub_responses: {
    list_tags_for_resource: {
      tag_list: [
        {
          key: 'Name',
          value: 'my-rds'
        }
      ]
    },
    describe_db_instances: {
      db_instances: [
        {
          db_instance_identifier: 'my-rds',
          db_instance_arn: 'arn:aws:rds:ap-northeast-1a:123456789012:db:my-rds',
          db_instance_status: 'available',
          db_instance_class: 'db.t2.medium',
          vpc_security_groups: [
            {
              vpc_security_group_id: 'sg-5a6b7cd8'
            }
          ],
          db_subnet_group: {
            vpc_id: 'vpc-ab123cde',
            db_subnet_group_name: 'my-db-subnet-group',
            subnets: [
              {
                subnet_identifier: 'subnet-8901b123',
                subnet_availability_zone: {
                  name: 'ap-northeast-1a'
                }
              }
            ]
          },
          db_parameter_groups: [
            {
              db_parameter_group_name: 'default.mysql5.6',
              parameter_apply_status: 'pending-reboot'
            },
            {
              db_parameter_group_name: 'custom.mysql5.6',
              parameter_apply_status: 'in-sync'
            }
          ],
          option_group_memberships: [
            {
              option_group_name: 'default:mysql-5-6',
              status: 'in-sync'
            },
            {
              option_group_name: 'custom:mysql-5-6',
              status: 'in-sync'
            }
          ],
          availability_zone: 'ap-northeast-1a',
          multi_az: false
        }
      ]
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
