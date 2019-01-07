Aws.config[:redshift] = {
  stub_responses: {
    describe_clusters: {
      clusters: [
        {
          cluster_identifier: 'my-redshift',
          node_type: 't2.medium',
          cluster_status: 'available',
          db_name: 'my-db',
          vpc_security_groups: [
            {
              vpc_security_group_id: 'sg-1a2b3c4d',
              status: 'active'
            }
          ],
          cluster_parameter_groups: [
            {
              parameter_group_name: 'my-pg',
              parameter_apply_status: 'in-sync'
            }
          ],
          cluster_subnet_group_name: 'my-sg',
          vpc_id: 'vpc-ab123cde',
          availability_zone: 'ap-northeast-1a',
          tags: [
            {
              key: 'Name',
              value: 'my-cluster'
            }
          ]
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
          group_id: 'sg-1a2b3c4d',
          group_name: 'group-name-sg',
          tags: [
            {
              key: 'Name',
              value: 'my-db-sg'
            }
          ]
        }
      ]
    }
  }
}
