# frozen_string_literal: true

Aws.config[:elasticache] = {
  stub_responses: {
    describe_cache_clusters: {
      cache_clusters:
        [
          {
            cache_cluster_id: 'my-rep-group-001',
            configuration_endpoint: nil,
            client_download_landing_page:
              'https://console.aws.amazon.com/elasticache/home#client-download:',
            cache_node_type: 'cache.m3.medium',
            engine: 'redis',
            engine_version: '2.8.21',
            cache_cluster_status: 'available',
            num_cache_nodes: 1,
            preferred_availability_zone: 'ap-northeast-1b',
            cache_cluster_create_time: Time.new(2015, 1, 2, 10, 00, 00, '+00:00'),
            preferred_maintenance_window: 'wed:15:30-wed:16:30',
            pending_modified_values:
              {
                num_cache_nodes: nil,
                cache_node_ids_to_remove: [],
                engine_version: nil
              },
            notification_configuration: nil,
            cache_security_groups: [],
            cache_parameter_group:
              {
                cache_parameter_group_name: 'my-cache-parameter-group',
                parameter_apply_status: 'in-sync',
                cache_node_ids_to_reboot: []
              },
            cache_subnet_group_name: 'my-cache-subnet-group',
            cache_nodes: [],
            auto_minor_version_upgrade: true,
            security_groups: [
              {
                security_group_id: 'sg-da1bc2ef',
                status: 'active'
              }
            ],
            replication_group_id: 'my-rep-group',
            snapshot_retention_limit: 0,
            snapshot_window: '17:30-18:30'
          },
          {
            cache_cluster_id: 'my-valkey-001',
            configuration_endpoint: nil,
            client_download_landing_page:
              'https://console.aws.amazon.com/elasticache/home#client-download:',
            cache_node_type: 'cache.m7g.large',
            engine: 'valkey',
            engine_version: '7.1.0',
            cache_cluster_status: 'available',
            num_cache_nodes: 1,
            preferred_availability_zone: 'ap-northeast-1b',
            cache_cluster_create_time: Time.new(2015, 1, 2, 10, 00, 00, '+00:00'),
            preferred_maintenance_window: 'wed:15:30-wed:16:30',
            pending_modified_values:
              {
                num_cache_nodes: nil,
                cache_node_ids_to_remove: [],
                engine_version: nil
              },
            notification_configuration: nil,
            cache_security_groups: [],
            cache_parameter_group:
              {
                cache_parameter_group_name: 'my-cache-parameter-group',
                parameter_apply_status: 'in-sync',
                cache_node_ids_to_reboot: []
              },
            cache_subnet_group_name: 'my-cache-subnet-group',
            cache_nodes: [],
            auto_minor_version_upgrade: true,
            security_groups: [
              {
                security_group_id: 'sg-da1bc2ef',
                status: 'active'
              }
            ],
            replication_group_id: 'my-valkey',
            snapshot_retention_limit: 0,
            snapshot_window: '17:30-18:30'
          }
        ]
    },
    describe_cache_subnet_groups: {
      cache_subnet_groups: [
        {
          cache_subnet_group_name: 'my-cache-subnet-group',
          cache_subnet_group_description: 'stub',
          vpc_id: 'vpc-ab123cde',
          subnets: []
        }
      ]
    },
    describe_replication_groups: {
      replication_groups: [
        {
          replication_group_id: 'my-rep-group',
          status: 'available',
          engine: 'redis',
          engine_version: '7.1',
          cache_subnet_group_name: 'my-cache-subnet-group',
          cache_parameter_group: {
            cache_parameter_group_name: 'my-cache-parameter-group'
          },
          member_clusters: [
            'my-rep-group-001',
            'my-rep-group-002'
          ],
          cluster_enabled: true,
          node_groups: [
            {
              node_group_members: [
                { cache_cluster_id: 'my-rep-group-001' },
                { cache_cluster_id: 'my-rep-group-002' }
              ]
            }
          ]
        },
        {
          replication_group_id: 'my-valkey',
          status: 'available',
          engine: 'valkey',
          engine_version: nil,
          cache_subnet_group_name: 'my-cache-subnet-group',
          cache_parameter_group: {
            cache_parameter_group_name: 'my-cache-parameter-group'
          },
          member_clusters: [
            'my-valkey-001'
          ],
          cluster_enabled: false,
          node_groups: [
            {
              node_group_members: [
                { cache_cluster_id: 'my-valkey-001' }
              ]
            }
          ]
        }
      ]
    },
    describe_serverless_caches: {
      serverless_caches: [
        {
          serverless_cache_name: 'my-serverless-cache',
          status: 'available',
          engine: 'valkey',
          engine_version: '7.2'
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
          group_id: 'sg-da1bc2ef',
          group_name: 'group-name-sg',
          tags: [
            {
              key: 'Name',
              value: 'my-cache-sg'
            }
          ]
        }
      ]
    }
  }
}
