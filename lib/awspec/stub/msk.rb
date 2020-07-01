Aws.config[:kafka] = {
  stub_responses: {
    list_clusters: {
      cluster_info_list: [
        {
          active_operation_arn: nil,
          broker_node_group_info: {
            broker_az_distribution: 'DEFAULT',
            client_subnets: [
              'subnet-12345678909876543',
              'subnet-90876543212345678'
            ],
            instance_type: 'kafka.t3.small',
            security_groups: [
              'sg-65432123456789098'
            ],
            storage_info: {
              ebs_storage_info: {
                volume_size: 1
              }
            }
          },
          client_authentication: nil,
          cluster_arn: 'arn:aws:kafka:us-east-1:123456789098:cluster/did-inventory/\
          a12345b6-123c-1de2-1234-f1g23h45i678-9',
          cluster_name: 'my-msk',
          creation_time: Time.new(2019, 1, 2, 10, 10, 00, '+00:00'),
          current_broker_software_info: {
            configuration_arn: nil,
            configuration_revision: nil,
            kafka_version: '2.2.1'
          },
          logging_info: {
            broker_logs: {
              cloud_watch_logs: {
                enabled: false,
                log_group: nil
              },
              firehose: {
                delivery_stream: nil,
                enabled: false
              },
              s3: {
                bucket: nil,
                enabled: false,
                prefix: nil
              }
            }
          },
          current_version: 'A1BCDEFGHI23JK',
          encryption_info: {
            encryption_at_rest: {
              data_volume_kms_key_id: 'arn:aws:kms:us-east-1:123456789098:key/ab1c2345-6789-01d2-3ee4-f56gh7i890jk'
            },
            encryption_in_transit: {
              client_broker: 'TLS_PLAINTEXT',
              in_cluster: true
            }
          },
          enhanced_monitoring: 'DEFAULT',
          number_of_broker_nodes: 2,
          open_monitoring: {
            prometheus: {
              jmx_exporter: {
                enabled_in_broker: false
              },
              node_exporter: {
                enabled_in_broker: false
              }
            }
          },
          state: 'ACTIVE',
          tags: {
            'Name' => 'my-msk'
          },
          zookeeper_connect_string: 'z-3.my-msk.1a23bc.d4.kafka.us-east-1.amazonaws.com:\
          1234,z-2.my-msk.1a23bc.d4.kafka.us-east-1.amazonaws.com:1234,z-1.my-msk.\
          1a23bc.d4.kafka.us-east-1.amazonaws.com:1234'
        }
      ],
      next_token: nil
    }
  }
}
