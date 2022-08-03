# frozen_string_literal: true

Aws.config[:rds] = {
  stub_responses: {
    describe_db_clusters: {
      db_clusters: [
        {
          allocated_storage: 1,
          availability_zones: %w[ap-northeast-1a ap-northeast-1c ap-northeast-1d],
          backup_retention_period: 1,
          character_set_name: nil,
          database_name: 'example_db',
          db_cluster_identifier: 'my-rds-db-cluster',
          db_cluster_parameter_group: 'default.aurora-mysql5.7',
          db_subnet_group: 'default',
          status: 'available',
          automatic_restart_time: nil,
          percent_progress: nil,
          earliest_restorable_time: Time.local(2022),
          endpoint: 'my-rds-db-cluster.cluster-abcdefghij12.ap-northeast-1.rds.amazonaws.com',
          reader_endpoint: 'my-rds-db-cluster.cluster-ro-abcdefghij12.ap-northeast-1.rds.amazonaws.com',
          custom_endpoints: [],
          multi_az: false,
          engine: 'aurora-mysql',
          engine_version: '5.7.mysql_aurora.2.10.2',
          latest_restorable_time: Time.local(2022),
          port: 3306,
          master_username: 'username',
          db_cluster_option_group_memberships: [],
          preferred_backup_window: '14:09-14:39',
          preferred_maintenance_window: 'sun:17:01-sun:17:31',
          replication_source_identifier: nil,
          read_replica_identifiers: [
            'arn:aws:rds:ap-northeast-3:123456789012:cluster:my-rds-secondary-cluster'
          ],
          db_cluster_members: [
            {
              db_instance_identifier: 'my-rds-db-cluster-instance-1',
              is_cluster_writer: true,
              db_cluster_parameter_group_status: 'in-sync',
              promotion_tier: 0
            },
            {
              db_instance_identifier: 'my-rds-db-cluster-instance-2',
              is_cluster_writer: false,
              db_cluster_parameter_group_status: 'in-sync',
              promotion_tier: 0
            }
          ],
          vpc_security_groups: [
            {
              vpc_security_group_id: 'sg-5a6b7cd8',
              status: 'active'
            }
          ],
          hosted_zone_id: 'Z24O6O9L7SGTNB',
          storage_encrypted: false,
          kms_key_id: nil,
          db_cluster_resource_id: 'cluster-ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          db_cluster_arn: 'arn:aws:rds:ap-northeast-1:123456789012:cluster:my-rds-db-cluster',
          associated_roles: [],
          iam_database_authentication_enabled: false,
          clone_group_id: nil,
          cluster_create_time: Time.local(2022),
          earliest_backtrack_time: nil,
          backtrack_window: nil,
          backtrack_consumed_change_records: nil,
          enabled_cloudwatch_logs_exports: [],
          capacity: nil,
          engine_mode: 'provisioned',
          scaling_configuration_info: nil,
          deletion_protection: false,
          http_endpoint_enabled: false,
          activity_stream_mode: nil,
          activity_stream_status: 'stopped',
          activity_stream_kms_key_id: nil,
          activity_stream_kinesis_stream_name: nil,
          copy_tags_to_snapshot: false,
          cross_account_clone: false,
          domain_memberships: [],
          tag_list: [],
          global_write_forwarding_status: nil,
          global_write_forwarding_requested: false,
          pending_modified_values: nil,
          db_cluster_instance_class: nil,
          storage_type: nil,
          iops: nil,
          publicly_accessible: nil,
          monitoring_interval: nil,
          monitoring_role_arn: nil,
          performance_insights_enabled: nil,
          performance_insights_kms_key_id: nil,
          performance_insights_retention_period: nil,
          serverless_v2_scaling_configuration: nil
        }
      ],
      marker: nil
    }
  }
}

Aws.config[:ec2] = {
  stub_responses: {
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
    }
  }
}
