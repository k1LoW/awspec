# frozen_string_literal: true

Aws.config[:rds] = {
  stub_responses: {
    describe_global_clusters: {
      global_clusters: [
        {
          global_cluster_identifier: 'my-rds-global-cluster',
          global_cluster_resource_id: 'cluster-1234567890abcdef',
          global_cluster_arn: 'arn:aws:rds::123456789012:global-cluster:my-rds-global-cluster',
          status: 'available',
          engine: 'aurora-mysql',
          engine_version: '5.7.mysql_aurora.2.10.2',
          database_name: 'example_db',
          storage_encrypted: false,
          deletion_protection: false,
          global_cluster_members: [
            {
              db_cluster_arn: 'arn:aws:rds:ap-northeast-1:123456789012:cluster:my-primary-cluster',
              readers: [
                'arn:aws:rds:ap-northeast-3:123456789012:cluster:my-secondary-cluster'
              ],
              is_writer: true,
              global_write_forwarding_status: nil
            },
            {
              db_cluster_arn: 'arn:aws:rds:ap-northeast-3:123456789012:cluster:my-secondary-cluster',
              readers: [],
              is_writer: false,
              global_write_forwarding_status: 'disabled'
            }
          ],
          failover_state: nil
        }
      ],
      marker: nil
    }
  }
}
