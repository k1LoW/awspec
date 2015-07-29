require 'spec_helper'

Aws.config[:rds] = {
  stub_responses: {
    describe_db_instances: {
      db_instances: [
        {
          db_instance_identifier: 'my-rds',
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
              db_parameter_group_name: 'default.mysql5.6'
            },
            {
              db_parameter_group_name: 'custom.mysql5.6'
            }
          ],
          option_group_memberships: [
            {
              option_group_name: 'default:mysql-5-6'
            },
            {
              option_group_name: 'custom:mysql-5-6'
            }
          ],
          availability_zone: 'ap-northeast-1a'
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

describe rds('my-rds') do
  it { should exist }
  it { should be_available }
  it { should_not be_maintenance }
  its(:db_instance_class) { should eq 'db.t2.medium' }
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('group-name-sg') }
  it { should have_security_group('my-db-sg') }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_db_subnet_group('my-db-subnet-group') }
  it { should belong_to_subnet('subnet-8901b123') }
  it { should belong_to_subnet('db-subnet-a') }
  it { should have_db_parameter_group('default.mysql5.6') }
  it { should have_option_group('default:mysql-5-6') }
end
