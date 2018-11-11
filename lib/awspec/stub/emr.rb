Aws.config[:emr] = {
  stub_responses:  {
    describe_cluster: {
      cluster: {
        name: 'my cluster',
        log_uri: 's3n://aws-logs-232939870606-us-east-1/elasticmapreduce/',
        applications: [
          {
            name: 'Spark',
            version: '2.3.1',
            args: [],
            additional_info: {}
          },
          {
            name: 'Hadoop',
            version: '10.0.1',
            args: [],
            additional_info: {}
          }
        ],
        tags: [{ key: 'Name', value: 'My Cluster' }],
        status: {
          state: 'RUNNING',
          state_change_reason: {
            code: '',
            message: ''
          },
          timeline: {
            creation_date_time: Time.parse('2018-10-29 22:41:38 -0400'),
            ready_date_time: Time.parse('2018-10-29 22:41:38 -0400'),
            end_date_time: nil
          }
        },
        auto_scaling_role: 'EMR_AutoScaling_DefaultRole',
        scale_down_behavior: 'TERMINATE_AT_TASK_COMPLETION',
        ebs_root_volume_size: 30,
        instance_collection_type: 'INSTANCE_FLEET',
        security_configuration: 'sg-1828281-madeup',
        master_public_dns_name: 'ec2-54-167-31-38.compute-1.amazonaws.com',
        service_role: 'EMR_EC2_DefaultRole',
        visible_to_all_users: false,
        kerberos_attributes: {
          realm: 'EXAMPLE.COM',
          kdc_admin_password: 'password',
          cross_realm_trust_principal_password: 'emr-password',
          ad_domain_join_user: 'johny',
          ad_domain_join_password: 'begood'
        },
        ec2_instance_attributes: {
          ec2_key_name: 'my-key',
          ec2_subnet_id: 'sb-0bfc9360',
          requested_ec2_subnet_ids: [],
          ec2_availability_zone: 'us-east-1a',
          requested_ec2_availability_zones: [],
          emr_managed_master_security_group: 'sg-0bfc9360',
          emr_managed_slave_security_group: 'sg-0bfc9360',
          service_access_security_group: 'sg-0bfc9360',
          iam_instance_profile: 'EMR_EC2_DefaultRole',
          additional_master_security_groups: [],
          additional_slave_security_groups: []
        }
      }
    }
  }
}
