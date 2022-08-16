# frozen_string_literal: true

Aws.config[:rds] = {
  stub_responses: {
    describe_db_subnet_groups: {
      db_subnet_groups: [
        {
          db_subnet_group_name: 'my-rds-db-subnet-group',
          db_subnet_group_description: 'Created from the RDS Management Console',
          vpc_id: 'vpc-ab123cde',
          subnet_group_status: 'Complete',
          subnets: [
            {
              subnet_identifier: 'subnet-1234a567',
              subnet_availability_zone: {
                name: 'ap-northeast-1a'
              },
              subnet_outpost: {
                arn: nil
              },
              subnet_status: 'Active'
            },
            {
              subnet_identifier: 'subnet-1234b567',
              subnet_availability_zone: {
                name: 'ap-northeast-1c'
              },
              subnet_outpost: {
                arn: nil
              },
              subnet_status: 'Active'
            },
            {
              subnet_identifier: 'subnet-1234c567',
              subnet_availability_zone: {
                name: 'ap-northeast-1d'
              },
              subnet_outpost: {
                arn: nil
              },
              subnet_status: 'Active'
            }
          ],
          db_subnet_group_arn: 'arn:aws:rds:ap-northeast-1:123456789012:subgrp:my-rds-db-subnet-group'
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
    describe_subnets: {
      subnets: [
        {
          subnet_id: 'subnet-1234a567',
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
