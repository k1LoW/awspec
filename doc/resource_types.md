# Resource Types

[acm](#acm)
| [alb](#alb)
| [ami](#ami)
| [autoscaling_group](#autoscaling_group)
| [cloudfront_distribution](#cloudfront_distribution)
| [cloudtrail](#cloudtrail)
| [cloudwatch_alarm](#cloudwatch_alarm)
| [cloudwatch_event](#cloudwatch_event)
| [cloudwatch_logs](#cloudwatch_logs)
| [customer_gateway](#customer_gateway)
| [directconnect_virtual_interface](#directconnect_virtual_interface)
| [dynamodb_table](#dynamodb_table)
| [ebs](#ebs)
| [ec2](#ec2)
| [ecr_repository](#ecr_repository)
| [ecs_cluster](#ecs_cluster)
| [ecs_container_instance](#ecs_container_instance)
| [ecs_service](#ecs_service)
| [ecs_task_definition](#ecs_task_definition)
| [efs](#efs)
| [elasticache](#elasticache)
| [elasticache_cache_parameter_group](#elasticache_cache_parameter_group)
| [elasticsearch](#elasticsearch)
| [elastictranscoder_pipeline](#elastictranscoder_pipeline)
| [elb](#elb)
| [iam_group](#iam_group)
| [iam_policy](#iam_policy)
| [iam_role](#iam_role)
| [iam_user](#iam_user)
| [internet_gateway](#internet_gateway)
| [kms](#kms)
| [lambda](#lambda)
| [launch_configuration](#launch_configuration)
| [nat_gateway](#nat_gateway)
| [network_acl](#network_acl)
| [network_interface](#network_interface)
| [rds](#rds)
| [rds_db_cluster_parameter_group](#rds_db_cluster_parameter_group)
| [rds_db_parameter_group](#rds_db_parameter_group)
| [route53_hosted_zone](#route53_hosted_zone)
| [route_table](#route_table)
| [s3_bucket](#s3_bucket)
| [security_group](#security_group)
| [ses_identity](#ses_identity)
| [subnet](#subnet)
| [vpc](#vpc)
| [vpn_connection](#vpn_connection)
| [vpn_gateway](#vpn_gateway)
| [waf_web_acl](#waf_web_acl)
| [account](#account)

## <a name="acm">acm</a>

Acm resource type.

### exist

```ruby
describe acm('example.com') do
  it { should exist }
end
```


### be_pending_validation, be_issued, be_inactive, be_expired, be_validation_timed_out, be_revoked, be_failed

### its(:certificate_arn), its(:domain_name), its(:subject_alternative_names), its(:domain_validation_options), its(:serial), its(:subject), its(:issuer), its(:created_at), its(:issued_at), its(:imported_at), its(:status), its(:revoked_at), its(:revocation_reason), its(:not_before), its(:not_after), its(:key_algorithm), its(:signature_algorithm), its(:in_use_by), its(:failure_reason), its(:type), its(:renewal_summary)
## <a name="alb">alb</a>

ALB resource type.

### exist

```ruby
describe alb('my-alb') do
  it { should exist }
end
```


### be_active, be_provisioning, be_failed

```ruby
describe alb('my-alb') do
  it { should be_active }
end
```


### have_security_group

```ruby
describe alb('my-alb') do
  it { should have_security_group('sg-1a2b3cd4') }
end
```



### its(:load_balancer_arn), its(:dns_name), its(:canonical_hosted_zone_id), its(:created_time), its(:load_balancer_name), its(:scheme), its(:vpc_id), its(:type), its(:security_groups), its(:ip_address_type)
## <a name="ami">ami</a>

AMI resource type.

### exist

```ruby
describe ami('my-ami') do
  it { should exist }
end
```


### be_pending, be_available, be_invalid, be_deregistered, be_transient, be_failed, be_error

```ruby
describe ami('my-ami') do
  it { should be_available }
end
```


### its(:image_id), its(:image_location), its(:state), its(:owner_id), its(:creation_date), its(:public), its(:architecture), its(:image_type), its(:kernel_id), its(:ramdisk_id), its(:platform), its(:sriov_net_support), its(:ena_support), its(:state_reason), its(:image_owner_alias), its(:name), its(:description), its(:root_device_type), its(:root_device_name), its(:virtualization_type), its(:tags), its(:hypervisor)
### :unlock: Advanced use

`ami` can use `Aws::EC2::Image` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Image.html).

## <a name="autoscaling_group">autoscaling_group</a>

AutoscalingGroup resource type.

### exist

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should exist }
end
```


### have_ec2

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_ec2('my-ec2') }
end
```


### have_elb

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_elb('my-elb') }
end
```


### have_tag

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_tag('Name').value('my-group') }
end
```

### its(:auto_scaling_group_name), its(:auto_scaling_group_arn), its(:launch_configuration_name), its(:min_size), its(:max_size), its(:desired_capacity), its(:default_cooldown), its(:availability_zones), its(:load_balancer_names), its(:target_group_arns), its(:health_check_type), its(:health_check_grace_period), its(:created_time), its(:suspended_processes), its(:placement_group), its(:vpc_zone_identifier), its(:enabled_metrics), its(:status), its(:termination_policies), its(:new_instances_protected_from_scale_in)
## <a name="cloudfront_distribution">cloudfront_distribution</a>

CloudfrontDistribution resource type.

### exist

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should exist }
end
```


### be_in_progress, be_deployed

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should be_deployed }
end
```


### have_origin

```ruby
describe cloudfront_distribution('E2CLOUDFRONTXX') do
  it do
    should have_origin('cf-s3-origin-hosting.dev.example.com')
      .domain_name('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com')
      .origin_path('/img')
      .origin_access_identity('origin-access-identity/cloudfront/E2VVVVVVVVVVVV')
  end
end
```


### have_origin_domain_name

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should have_origin_domain_name('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com') }
end
```


### have_origin_domain_name_and_path

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should have_origin_domain_name_and_path('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com/img') }
end
```

### its(:id), its(:arn), its(:status), its(:last_modified_time), its(:domain_name), its(:comment), its(:price_class), its(:enabled), its(:web_acl_id), its(:http_version), its(:is_ipv6_enabled)
## <a name="cloudtrail">cloudtrail</a>

Cloudtrail resource type.

### exist

```ruby
describe cloudtrail('my-trail') do
  it { should exist }
end
```


### be_logging

```ruby
describe cloudtrail('my-trail') do
  it { should be_logging }
end
```

### be_multi_region_trail

```ruby
describe cloudtrail('my-trail') do
  it { should be_multi_region_trail }
end
```


### have_global_service_events_included

```ruby
describe cloudtrail('my-trail') do
  it { should have_global_service_events_included }
end
```


### have_log_file_validation_enabled

```ruby
describe cloudtrail('my-trail') do
  it { should have_log_file_validation_enabled }
end
```


### its(:name), its(:s3_bucket_name), its(:s3_key_prefix), its(:sns_topic_name), its(:sns_topic_arn), its(:include_global_service_events), its(:is_multi_region_trail), its(:home_region), its(:trail_arn), its(:log_file_validation_enabled), its(:cloud_watch_logs_log_group_arn), its(:cloud_watch_logs_role_arn), its(:kms_key_id), its(:has_custom_event_selectors)
## <a name="cloudwatch_alarm">cloudwatch_alarm</a>

CloudwatchAlarm resource type.

### exist

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should exist }
end
```


### have_alarm_action

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should have_alarm_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
end
```


### have_insufficient_data_action

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should have_insufficient_data_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
end
```


### have_ok_action

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should have_ok_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
end
```


### belong_to_metric

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should belong_to_metric('NumberOfProcesses').namespace('my-cloudwatch-namespace') }
end
```

### its(:alarm_name), its(:alarm_arn), its(:alarm_description), its(:alarm_configuration_updated_timestamp), its(:actions_enabled), its(:ok_actions), its(:alarm_actions), its(:insufficient_data_actions), its(:state_value), its(:state_reason), its(:state_reason_data), its(:state_updated_timestamp), its(:metric_name), its(:namespace), its(:statistic), its(:extended_statistic), its(:period), its(:unit), its(:evaluation_periods), its(:threshold), its(:comparison_operator)
## <a name="cloudwatch_event">cloudwatch_event</a>

CloudwatchEvent resource type.

### exist

### be_enable

### be_scheduled

### its(:name), its(:arn), its(:event_pattern), its(:state), its(:description), its(:schedule_expression), its(:role_arn)
## <a name="cloudwatch_logs">cloudwatch_logs</a>

CloudwatchLogs resource type.

### exist

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should exist }
end
```


### have_log_stream

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_log_stream('my-cloudwatch-logs-stream') }
end
```


### have_metric_filter

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_metric_filter('my-cloudwatch-logs-metric-filter') }
end
```


### have_subscription_filter

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_subscription_filter('my-cloudwatch-logs-subscription-filter') }
end
```
or
```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it do
    should have_subscription_filter('my-cloudwatch-logs-subscription-filter')\
      .filter_pattern('[host, ident, authuser, date, request, status, bytes]')
  end
end
```

### its(:log_group_name), its(:creation_time), its(:retention_in_days), its(:metric_filter_count), its(:arn), its(:stored_bytes)
## <a name="customer_gateway">customer_gateway</a>

CustomerGateway resource type.

### exist

```ruby
describe customer_gateway('my-customer-gateway') do
  it { should exist }
end
```


### be_pending, be_available, be_deleting, be_deleted

```ruby
describe customer_gateway('my-customer-gateway') do
  it { should be_running }
end
```


### have_tag

```ruby
describe customer_gateway('my-customer-gateway') do
  it { should have_tag('Name').value('my-customer-gateway') }
end
```


### its(:customer_gateway_id), its(:state), its(:type), its(:ip_address), its(:bgp_asn), its(:tags)
## <a name="directconnect_virtual_interface">directconnect_virtual_interface</a>

DirectconnectVirtualInterface resource type.

```ruby
describe directconnect_virtual_interface('my-directconnect-virtual-interface') do
  it { should exist }
  it { should be_available }
  its(:connection_id) { should eq 'dxcon-abcd5fgh' }
  its(:virtual_interface_id) { should eq 'dxvif-aabbccdd' }
  its(:amazon_address) { should eq '170.252.252.1/30' }
  its(:customer_address) { should eq '123.456.789.2/30' }
  its(:virtual_gateway_id) { should eq 'vgw-d234e5f6' }
end
```


### exist

```ruby
describe directconnect_virtual_interface('my-directconnect-virtual-interface') do
  it { should exist }
end
```


### be_confirming, be_verifying, be_pending, be_available, be_deleting, be_deleted, be_rejected

```ruby
describe directconnect_virtual_interface('my-directconnect-virtual-interface') do
  it { should exist }
  it { should be_available }
end
```

### its(:owner_account), its(:virtual_interface_id), its(:location), its(:connection_id), its(:virtual_interface_type), its(:virtual_interface_name), its(:vlan), its(:asn), its(:auth_key), its(:amazon_address), its(:customer_address), its(:address_family), its(:virtual_interface_state), its(:customer_router_config), its(:virtual_gateway_id), its(:route_filter_prefixes), its(:bgp_peers)
## <a name="dynamodb_table">dynamodb_table</a>

DynamodbTable resource type.

### exist

```ruby
describe dynamodb_table('my-dynamodb-table') do
  it { should exist }
end
```


### be_creating, be_updating, be_deleting, be_active

### have_attribute_definition

```ruby
describe dynamodb_table('my-dynamodb-table') do
  it { should have_attribute_definition('my-dynamodb-table-attaribute1').attribute_type('S') }
  it { should have_attribute_definition('my-dynamodb-table-attaribute2').attribute_type('N') }
end
```


### have_key_schema

```ruby
describe dynamodb_table('my-dynamodb-table') do
  it { should have_key_schema('my-dynamodb-table-key_schema1').key_type('HASH') }
  it { should have_key_schema('my-dynamodb-table-key_schema2').key_type('RANGE') }
end
```


### its(:table_name), its(:table_status), its(:creation_date_time), its(:table_size_bytes), its(:item_count), its(:table_arn), its(:local_secondary_indexes), its(:global_secondary_indexes), its(:stream_specification), its(:latest_stream_label), its(:latest_stream_arn)
### :unlock: Advanced use

`dynamodb_table` can use `Aws::DynamoDB::Table` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/DynamoDB/Table.html).

```ruby
describe dynamodb_table('my-dynamodb-table') do
  its('key_schema.first.key_type') { should eq 'HASH' }
end
```

or

```ruby
describe dynamodb_table('my-dynamodb-table') do
  its('resource.key_schema.first.key_type') { should eq 'HASH' }
end
```


## <a name="ebs">ebs</a>

EBS resource type.

### exist

```ruby
describe ebs('my-volume') do
  it { should exist }
end
```


### be_attached_to

```ruby
describe ebs('my-volume') do
  it { should be_attached_to('my-ec2') }
end
```


### be_creating, be_available, be_in_use, be_deleting, be_deleted, be_error

```ruby
describe ebs('my-volume') do
  it { should be_in_use }
end
```


### have_tag

```ruby
describe ebs('my-volume') do
  it { should have_tag('Name').value('my-volume') }
end
```


### its(:volume_id), its(:size), its(:snapshot_id), its(:availability_zone), its(:state), its(:create_time), its(:volume_type), its(:iops), its(:encrypted), its(:kms_key_id)
### :unlock: Advanced use

`ebs` can use `Aws::EC2::Volume` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Volume.html).

```ruby
describe ebs('my-volume') do
  its('attachments.first.instance_id') { should eq 'i-ec12345a' }
end
```

or

```ruby
describe ebs('my-volume') do
  its('resource.attachments.first.instance_id') { should eq 'i-ec12345a' }
end
```

## <a name="ec2">ec2</a>

EC2 resource type.

### exist

```ruby
describe ec2('my-ec2') do
  it { should exist }
end
```


### be_disabled_api_termination

```ruby
describe ec2('my-ec2') do
  it { should be_disabled_api_termination }
end
```


### be_pending, be_running, be_shutting_down, be_terminated, be_stopping, be_stopped

```ruby
describe ec2('my-ec2') do
  it { should be_running }
end
```


### have_classiclink

```ruby
describe ec2('my-ec2-classic') do
  it { should have_classiclink('my-vpc') }
end
```


### have_classiclink_security_group

```ruby
describe ec2('my-ec2-classic') do
  it { should have_classiclink_security_group('sg-2a3b4cd5') }
  it { should have_classiclink_security_group('my-vpc-security-group-name') }
end
```


### have_ebs

```ruby
describe ec2('my-ec2') do
  it { should have_ebs('vol-123a123b') }
  it { should have_ebs('my-volume') }
end
```


### have_eip

```ruby
describe ec2('my-ec2') do
  it { should have_eip('123.0.456.789') }
end
```


### have_event

```ruby
describe ec2('my-ec2') do
  it { should have_event('system-reboot') }
end
```


### have_events

```ruby
describe ec2('my-ec2') do
  it { should_not have_events }
end
```


### have_iam_instance_profile

```ruby
describe ec2('my-ec2') do
  it { should have_iam_instance_profile('Ec2IamProfileName') }
end
```


### have_network_interface

```ruby
describe ec2('my-ec2') do
  it { should have_network_interface('my-eni') }
  it { should have_network_interface('eni-12ab3cde') }
  it { should have_network_interface('my-eni').as_eth0 }
end
```


### have_security_group

```ruby
describe ec2('my-ec2') do
  it { should have_security_group('my-security-group-name') }
  it { should have_security_group('sg-1a2b3cd4') }
end
```


### have_security_groups

```ruby
describe ec2('my-ec2') do
  it { should have_security_groups(['my-security-group-name-1', 'my-security-group-name-2']) }
  it { should have_security_groups(['sg-1a2b3cd4', 'sg-5e6f7gh8']) }
end
```


### have_tag

```ruby
describe ec2('my-ec2') do
  it { should have_tag('Name').value('my-ec2') }
end
```


### belong_to_subnet

```ruby
describe ec2('my-ec2') do
  it { should belong_to_subnet('subnet-1234a567') }
  it { should belong_to_subnet('my-subnet') }
end
```


### belong_to_vpc

```ruby
describe ec2('my-ec2') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```


### its(:instance_id), its(:image_id), its(:private_dns_name), its(:public_dns_name), its(:state_transition_reason), its(:key_name), its(:ami_launch_index), its(:product_codes), its(:instance_type), its(:launch_time), its(:placement), its(:kernel_id), its(:ramdisk_id), its(:platform), its(:monitoring), its(:subnet_id), its(:vpc_id), its(:private_ip_address), its(:public_ip_address), its(:state_reason), its(:architecture), its(:root_device_type), its(:root_device_name), its(:virtualization_type), its(:instance_lifecycle), its(:spot_instance_request_id), its(:client_token), its(:source_dest_check), its(:hypervisor), its(:ebs_optimized), its(:sriov_net_support), its(:ena_support)
### :unlock: Advanced use

`ec2` can use `Aws::EC2::Instance` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Instance.html).

```ruby
describe ec2('my-ec2') do
  its('vpc.id') { should eq 'vpc-ab123cde' }
end
```

or

```ruby
describe ec2('my-ec2') do
  its('resource.vpc.id') { should eq 'vpc-ab123cde' }
end
```

## <a name="ecr_repository">ecr_repository</a>

EcrRepository resource type.

### exist


## <a name="ecs_cluster">ecs_cluster</a>

ECS Cluster resource type.

### exist

```ruby
describe ecs_cluster('my-ecs-cluster') do
  it { should exist }
end
```


### be_active, be_inactive

```ruby
describe ecs_cluster('my-ecs-cluster') do
  it { should be_active }
end
```


### have_container_instance

```ruby
describe ecs_cluster('my-ecs-cluster') do
  it { have_container_instance('f2756532-8f13-4d53-87c9-aed50dc94cd7') }
end
```

### its(:cluster_arn), its(:cluster_name), its(:status), its(:registered_container_instances_count), its(:running_tasks_count), its(:pending_tasks_count), its(:active_services_count)
## <a name="ecs_container_instance">ecs_container_instance</a>

ECS Container Instance resource type.

### exist

You can set `cluster` ( default: `default` ).

```ruby
describe ecs_container_instance('my-container-instance'), cluster: 'my-ecs-cluster' do
  it { should exist }
end
```


### be_active, be_inactive

```ruby
describe ecs_container_instance('my-container-instance'), cluster: 'my-ecs-cluster' do
  it { should be_active }
end
```


### its(:container_instance_arn), its(:ec2_instance_id), its(:version), its(:version_info), its(:status), its(:agent_connected), its(:running_tasks_count), its(:pending_tasks_count), its(:agent_update_status), its(:attributes)
## <a name="ecs_service">ecs_service</a>

ECS Service resource type.

### exist

```ruby
describe ecs_service('my-ecs-service') do
  it { should exist }
end
```


### be_active, be_draining, be_inactive

```ruby
describe ecs_service('my-ecs-service') do
  it { should be_active }
end
```

### its(:service_arn), its(:service_name), its(:cluster_arn), its(:load_balancers), its(:status), its(:desired_count), its(:running_count), its(:pending_count), its(:task_definition), its(:role_arn), its(:created_at), its(:placement_constraints), its(:placement_strategy)
## <a name="ecs_task_definition">ecs_task_definition</a>

ECS Task Definition resource type.

### exist

```ruby
describe ecs_task_definition('my-ecs-task-definition') do
  it { should exist }
end
```


### be_active, be_inactive

```ruby
describe ecs_task_definition('my-ecs-task-definition') do
  it { should be_active }
end
```

### its(:task_definition_arn), its(:family), its(:task_role_arn), its(:network_mode), its(:revision), its(:volumes), its(:status), its(:requires_attributes), its(:placement_constraints)
## <a name="efs">efs</a>

EFS resource type.

### exist

```ruby
describe efs('my-efs') do
  it { should exist }
end
```


### have_tag

```ruby
describe efs('my-efs') do
  it { should have_tag('my-key').value('my-value') }
end
```

### its(:owner_id), its(:creation_token), its(:file_system_id), its(:creation_time), its(:life_cycle_state), its(:name), its(:number_of_mount_targets), its(:performance_mode)
## <a name="elasticache">elasticache</a>

Elasticache resource type.

### exist

```ruby
describe elasticache('my-rep-group-001') do
  it { should exist }
end
```


### be_available, be_creating, be_deleted, be_deleting, be_incompatible_network, be_modifying, be_rebooting_cache_cluster_nodes, be_restore_failed, be_snapshotting

```ruby
describe elasticache('my-rep-group-001') do
  it { should be_available }
end
```


### have_cache_parameter_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should have_cache_parameter_group('my-cache-parameter-group') }
end
```


### have_security_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should have_security_group('sg-da1bc2ef') }
  it { should have_security_group('group-name-sg') }
  it { should have_security_group('my-cache-sg') }
end
```


### belong_to_cache_subnet_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should belong_to_cache_subnet_group('my-cache-subnet-group') }
end
```


### belong_to_replication_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should belong_to_replication_group('my-rep-group') }
end
```


### belong_to_vpc

```ruby
describe elasticache('my-rep-group-001') do
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:cache_cluster_id), its(:configuration_endpoint), its(:client_download_landing_page), its(:cache_node_type), its(:engine), its(:engine_version), its(:cache_cluster_status), its(:num_cache_nodes), its(:preferred_availability_zone), its(:cache_cluster_create_time), its(:preferred_maintenance_window), its(:notification_configuration), its(:cache_security_groups), its(:cache_subnet_group_name), its(:cache_nodes), its(:auto_minor_version_upgrade), its(:replication_group_id), its(:snapshot_retention_limit), its(:snapshot_window)
## <a name="elasticache_cache_parameter_group">elasticache_cache_parameter_group</a>

ElasticacheCacheParameterGroup resource type.

```ruby
describe elasticache_cache_parameter_group('my-cache-parameter-group') do
  it { should exist }
  its(:activerehashing) { should eq 'yes' }
  its(:client_output_buffer_limit_pubsub_hard_limit) { should eq '33554432' }
end
```


### exist

```ruby
describe elasticache_cache_parameter_group('my-cache-parameter-group') do
  it { should exist }
end
```


## <a name="elasticsearch">elasticsearch</a>

Elasticsearch resource type.

### exist

```ruby
describe elasticsearch('my-elasticsearch') do
  it { should exist }
end
```


### be_created

```ruby
describe elasticsearch('my-elasticsearch') do
  it { should be_created }
end
```


### be_deleted

```ruby
describe elasticsearch('my-elasticsearch') do
  it { should be_deleted }
end
```


### have_access_policies

```ruby
describe elasticsearch('my-elasticsearch') do
 it do
    should have_access_policies <<-policy
{
  "version": "2012-10-17",
  "statement": [
    {
      "effect": "allow",
      "principal": "*",
      "action": [
        "es:*"
      ],
      "resource": "arn:aws:es:ap-northeast-1:1234567890:domain/my-elasticsearch/*"
    }
  ]
}
  policy
  end
end
```


### its(:domain_id), its(:domain_name), its(:arn), its(:created), its(:deleted), its(:endpoint), its(:processing), its(:elasticsearch_version), its(:access_policies), its(:snapshot_options), its(:advanced_options)
## <a name="elastictranscoder_pipeline">elastictranscoder_pipeline</a>

ElastictranscoderPipeline resource type.

### exist

### be_active, be_paused

```ruby
describe elastictranscoder_pipeline('my-elastictranscoder-pipeline') do
  it { should be_active }
end
```


## <a name="elb">elb</a>

ELB resource type.

### exist

```ruby
describe elb('my-elb') do
  it { should exist }
end
```


### have_ec2

```ruby
describe elb('my-elb') do
  it { should have_ec2('my-ec2') }
end
```


### have_listener

http://docs.aws.amazon.com/en_us/ElasticLoadBalancing/latest/DeveloperGuide/elb-listener-config.html

```ruby
describe elb('my-elb') do
  it { should have_listener(protocol: 'HTTPS', port: 443, instance_protocol: 'HTTP', instance_port: 80) }
end
```


### have_security_group

```ruby
describe elb('my-elb') do
  it { should have_security_group('my-lb-security-group-tag-name') }
end
```


### have_subnet

```ruby
describe elb('my-elb') do
  it { should have_subnet('my-subnet') }
end
```


### belong_to_vpc

```ruby
describe elb('my-elb') do
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:health_check_target), its(:health_check_interval), its(:health_check_timeout), its(:health_check_unhealthy_threshold), its(:health_check_healthy_threshold), its(:load_balancer_name), its(:dns_name), its(:canonical_hosted_zone_name), its(:canonical_hosted_zone_name_id), its(:backend_server_descriptions), its(:availability_zones), its(:subnets), its(:vpc_id), its(:security_groups), its(:created_time), its(:scheme)
## <a name="iam_group">iam_group</a>

IamGroup resource type.

### exist

```ruby
describe iam_group('my-iam-group') do
  it { should exist }
end
```


### be_allowed_action

```ruby
describe iam_group('my-iam-group') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```


### have_iam_policy

```ruby
describe iam_group('my-iam-group') do
  it { should have_iam_policy('ReadOnlyAccess') }
end
```


### have_iam_user

```ruby
describe iam_group('my-iam-group') do
  it { should have_iam_user('my-iam-user') }
end
```


### have_inline_policy

### its(:path), its(:group_name), its(:group_id), its(:arn), its(:create_date)
### :unlock: Advanced use

`iam_group` can use `Aws::IAM::Group` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/IAM/Group.html).

```ruby
describe iam_group('my-iam-group') do
  its('users.count) { should eq 5 }
end
```

or

```ruby
describe iam_group('my-iam-group') do
  its('resource.users.count') { should eq 5 }
end
```

## <a name="iam_policy">iam_policy</a>

IamPolicy resource type.

### exist

```ruby
describe iam_policy('my-iam-policy') do
  it { should exist }
end
```


### be_attachable

```ruby
describe iam_policy('my-iam-policy') do
  it { should be_attachable }
end
```


### be_attached_to_group

```ruby
describe iam_policy('my-iam-policy') do
  it { should be_attached_to_group('my-iam-group') }
end
```


### be_attached_to_role

```ruby
describe iam_policy('my-iam-policy') do
  it { should be_attached_to_role('HelloIAmGodRole') }
end
```


### be_attached_to_user

```ruby
describe iam_policy('my-iam-user') do
  it { should be_attached_to_user('my-iam-user') }
end
```

### its(:policy_name), its(:policy_id), its(:arn), its(:path), its(:default_version_id), its(:attachment_count), its(:is_attachable), its(:description), its(:create_date), its(:update_date)
## <a name="iam_role">iam_role</a>

IamRole resource type.

### exist

```ruby
describe iam_role('my-iam-role') do
  it { should exist }
end
```


### be_allowed_action

```ruby
describe iam_role('my-iam-role') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```


### have_iam_policy

```ruby
describe iam_role('my-iam-role') do
  it { should have_iam_policy('ReadOnlyAccess') }
end
```


### have_inline_policy

```ruby
describe iam_role('my-iam-role') do
  it { should have_inline_policy('AllowS3BucketAccess') }
  it do
    should have_inline_policy('AllowS3BucketAccess').policy_document(<<-'DOC')
{
"Statement": [
    {
     "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
    }
  ]
}
DOC
  end
end
```


### its(:path), its(:role_name), its(:role_id), its(:arn), its(:create_date), its(:assume_role_policy_document)
### :unlock: Advanced use

`iam_role` can use `Aws::IAM::Role` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/IAM/Role.html).

```ruby
describe iam_role('my-iam-role') do
  its('attached_policies.count') { should eq 5 }
end
```

or

```ruby
describe iam_role('my-iam-role') do
  its('resource.attached_policies.count') { should eq 5 }
end
```

## <a name="iam_user">iam_user</a>

IamUser resource type.

### exist

```ruby
describe iam_user('my-iam-user') do
  it { should exist }
end
```


### be_allowed_action

```ruby
describe iam_user('my-iam-user') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```


### have_iam_policy

```ruby
describe iam_user('my-iam-user') do
  it { should have_iam_policy('ReadOnlyAccess') }
end
```


### have_inline_policy

```ruby
describe iam_user('my-iam-user') do
  it { should have_inline_policy('AllowS3BucketAccess') }
  it do
    should have_inline_policy('AllowS3BucketAccess').policy_document(<<-'DOC')
{
"Statement": [
    {
     "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
    }
  ]
}
DOC
  end
end
```


### belong_to_iam_group

```ruby
describe iam_user('my-iam-user') do
  it { should belong_to_iam_group('my-iam-group') }
end
```


### its(:path), its(:user_name), its(:user_id), its(:arn), its(:create_date), its(:password_last_used)
### :unlock: Advanced use

`iam_user` can use `Aws::IAM::User` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/IAM/User.html).

```ruby
describe iam_user('my-iam-user') do
  its('login_profile.password_reset_required') { should eq false }
end
```

or

```ruby
describe iam_user('my-iam-user') do
  its('resource.login_profile.password_reset_required') { should eq false }
end
```

## <a name="internet_gateway">internet_gateway</a>

InternetGateway resource type.

### exist

```ruby
describe internet_gateway('igw-1ab2cd3e') do
  it { should exist }
end

describe internet_gateway('my-internet-gateway') do
  it { should exist }
end
```


### be_attached_to

```ruby
describe internet_gateway('igw-1ab2cd3e') do
  it { should be_attached_to('vpc-ab123cde') }
end

describe internet_gateway('igw-1ab2cd3e') do
  it { should be_attached_to('my-vpc') }
end
```


### have_tag

```ruby
describe internet_gateway('igw-1ab2cd3e') do
  it { should have_tag('Name').value('my-internet-gateway') }
end
```

### its(:internet_gateway_id)
## <a name="kms">kms</a>

Kms resource type.

### exist

```ruby
describe kms('my-kms-key') do
  it { should exist }
end
```


### be_enabled

```ruby
describe kms('my-kms-key') do
  it { should be_enabled }
end
```


### have_key_policy

```ruby
describe kms('my-kms-key') do
  it { should exist }
  it { should be_enabled }
  it do
    should have_key_policy('default').policy_document(<<-'DOC')
{
  "Version" : "2012-10-17",
  "Id" : "key-consolepolicy-2",
  "Statement" : [ {
    "Sid" : "Enable IAM User Permissions",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::1234567890:root"
    },
    "Action" : "kms:*",
    "Resource" : "*"
  }, {
    "Sid" : "Allow access for Key Administrators",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::1234567890:user/test-user"
    },
    "Action" : [ "kms:Create*", "kms:Describe*", "kms:Enable*", "kms:List*", "kms:Put*", "kms:Update*", "kms:Revoke*", "kms:Disable*", "kms:Get*", "kms:Delete*", "kms:ScheduleKeyDeletion", "kms:CancelKeyDeletion" ],
    "Resource" : "*"
  }, {
    "Sid" : "Allow use of the key",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : [ "arn:aws:iam::1234567890:user/test-user", "arn:aws:iam::1234567890:role/test-role" ]
    },
    "Action" : [ "kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:DescribeKey" ],
    "Resource" : "*"
  }, {
    "Sid" : "Allow attachment of persistent resources",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : [ "arn:aws:iam::1234567890:user/test-user", "arn:aws:iam::1234567890:role/test-role" ]
    },
    "Action" : [ "kms:CreateGrant", "kms:ListGrants", "kms:RevokeGrant" ],
    "Resource" : "*",
    "Condition" : {
      "Bool" : {
        "kms:GrantIsForAWSResource" : "true"
      }
    }
  } ]
}
DOC
  end
end
```

### its(:aws_account_id), its(:key_id), its(:arn), its(:creation_date), its(:enabled), its(:description), its(:key_usage), its(:key_state), its(:deletion_date), its(:valid_to), its(:origin), its(:expiration_model)
## <a name="lambda">lambda</a>

Lambda resource type.

### exist

```ruby
describe lambda('my-lambda-function-name') do
  it { should exist }
end
```


### have_event_source

This matcher does not support Amazon S3 event sources. ( [See SDK doc](http://docs.aws.amazon.com/sdkforruby/api/Aws/Lambda/Client.html#list_event_source_mappings-instance_method) )

### its(:function_name), its(:function_arn), its(:runtime), its(:role), its(:handler), its(:code_size), its(:description), its(:timeout), its(:memory_size), its(:last_modified), its(:code_sha_256), its(:version), its(:vpc_config), its(:dead_letter_config), its(:environment), its(:kms_key_arn)
## <a name="launch_configuration">launch_configuration</a>

LaunchConfiguration resource type.

### exist

```ruby
describe launch_configuration('my-lc') do
  it { should exist }
end
```


### have_security_group

```ruby
describe launch_configuration('my-lc') do
  it { should have_security_group('my-security-group-name') }
end
```

### its(:launch_configuration_name), its(:launch_configuration_arn), its(:image_id), its(:key_name), its(:security_groups), its(:classic_link_vpc_id), its(:classic_link_vpc_security_groups), its(:user_data), its(:instance_type), its(:kernel_id), its(:ramdisk_id), its(:block_device_mappings), its(:spot_price), its(:iam_instance_profile), its(:created_time), its(:ebs_optimized), its(:associate_public_ip_address), its(:placement_tenancy)
## <a name="nat_gateway">nat_gateway</a>

NatGateway resource type.

### exist

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should exist }
end
```


### be_pending, be_failed, be_available, be_deleting, be_deleted

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should be_available }
end
```


### have_eip

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should have_eip('123.0.456.789') }
end
```


### belong_to_vpc

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:vpc_id), its(:subnet_id), its(:nat_gateway_id), its(:create_time), its(:delete_time), its(:state), its(:failure_code), its(:failure_message), its(:provisioned_bandwidth)
## <a name="network_acl">network_acl</a>

NetworkAcl resource type.

### exist

```ruby
describe network_acl('my-network-acl') do
  it { should exist }
end
```


### have_subnet

```ruby
describe network_acl('my-network-acl') do
  it { should have_subnet('my-subnet') }
end
```


### have_tag

```ruby
describe network_acl('my-network-acl') do
  it { should have_tag('Name').value('my-network-acl') }
end
```


### belong_to_vpc

```ruby
describe network_acl('my-network-acl') do
  it { should belong_to_vpc('my-vpc') }
end
```


### its(:inbound), its(:outbound), its(:inbound_entries_count), its(:outbound_entries_count)

```ruby
describe network_acl('my-network-acl') do
  its(:inbound) { should be_allowed(80).protocol('tcp').source('123.0.456.789/32') }
  its(:inbound) { should be_denied.rule_number('*').source('0.0.0.0/0') }
  its(:outbound) { should be_allowed.protocol('ALL').source('0.0.0.0/0') }
  its(:inbound_entries_count) { should eq 3 }
  its(:outbound_entries_count) { should eq 2 }
end
```


### its(:inbound_entries_count), its(:outbound_entries_count), its(:network_acl_id), its(:vpc_id), its(:is_default)
### :unlock: Advanced use

`network_acl` can use `Aws::EC2::NetworkAcl` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/NetworkAcl.html).

```ruby
describe network_acl('my-network-acl') do
  its('vpc.id') { should eq 'vpc-ab123cde' }
end
```

or

```ruby
describe network_acl('my-network-acl') do
  its('resource.vpc.id') { should eq 'vpc-ab123cde' }
end
```

## <a name="network_interface">network_interface</a>

NetworkInterface resource type.

### exist

```ruby
describe network_interface('eni-12ab3cde') do
  it { should exist }
end
```


### be_attached_to

```ruby
describe network_interface('eni-12ab3cde') do
  it { should be_attached_to('my-ec2') }
  it { should be_attached_to('my-ec2').as_eth0 }
end
```


### be_available, be_attaching, be_in_use, be_detaching

```ruby
describe network_interface('eni-12ab3cde') do
  it { should be_in_use }
end
```


### have_private_ip_address

```ruby
describe network_interface('eni-12ab3cde') do
  it { should have_private_ip_address('10.0.1.1').primary }
  it { should have_private_ip_address('10.0.1.2') }
  its(:private_ip_addresses_count) { should eq 2 }
end
```


### have_security_group

```ruby
describe network_interface('eni-12ab3cde') do
  it { should have_security_group('my-security-group-name') }
end
```


### have_tag

```ruby
describe network_interface('eni-12ab3cde') do
  it { should have_tag('Name').value('my-eni') }
end
```


### belong_to_subnet

```ruby
describe network_interface('eni-12ab3cde') do
  it { should belong_to_subnet('my-subnet') }
end
```


### belong_to_vpc

```ruby
describe network_interface('eni-12ab3cde') do
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:network_interface_id), its(:subnet_id), its(:vpc_id), its(:availability_zone), its(:description), its(:owner_id), its(:requester_id), its(:requester_managed), its(:status), its(:mac_address), its(:private_ip_address), its(:private_dns_name), its(:source_dest_check), its(:association), its(:ipv_6_addresses), its(:interface_type)
## <a name="rds">rds</a>

RDS resource type.

### exist

```ruby
describe rds('my-rds') do
  it { should exist }
end
```


### be_available, be_backing_up, be_creating, be_deleting, be_failed, be_inaccessible_encryption_credentials, be_incompatible_credentials, be_incompatible_network, be_incompatible_option_group, be_incompatible_parameters, be_incompatible_restore, be_maintenance, be_modifying, be_rebooting, be_renaming, be_resetting_master_credentials, be_restore_error, be_storage_full, be_upgrading

```ruby
describe rds('my-rds') do
  it { should be_available }
end
```


### have_db_parameter_group

```ruby
describe rds('my-rds') do
  it { should have_db_parameter_group('my-db-parameter-group') }
end
```


### have_option_group

```ruby
describe rds('my-rds') do
  it { should have_option_group('default:mysql-5-6') }
end
```


### have_security_group

```ruby
describe rds('my-rds') do
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('my-db-sg') }
end
```


### have_tag

```ruby
describe rds('my-rds') do
  it { should have_tag('Name').value('my-rds') }
end
```


### belong_to_db_subnet_group

```ruby
describe rds('my-rds') do
  it { should belong_to_db_subnet_group('my-db-subnet-group') }
end
```


### belong_to_subnet

```ruby
describe rds('my-rds') do
  it { should belong_to_subnet('subnet-8901b123') }
  it { should belong_to_subnet('db-subnet-a') }
end
```


### belong_to_vpc

```ruby
describe rds('my-rds') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```


### its(:vpc_id), its(:db_instance_identifier), its(:db_instance_class), its(:engine), its(:db_instance_status), its(:master_username), its(:db_name), its(:endpoint), its(:allocated_storage), its(:instance_create_time), its(:preferred_backup_window), its(:backup_retention_period), its(:db_security_groups), its(:availability_zone), its(:preferred_maintenance_window), its(:pending_modified_values), its(:latest_restorable_time), its(:multi_az), its(:engine_version), its(:auto_minor_version_upgrade), its(:read_replica_source_db_instance_identifier), its(:read_replica_db_instance_identifiers), its(:read_replica_db_cluster_identifiers), its(:license_model), its(:iops), its(:character_set_name), its(:secondary_availability_zone), its(:publicly_accessible), its(:status_infos), its(:storage_type), its(:tde_credential_arn), its(:db_instance_port), its(:db_cluster_identifier), its(:storage_encrypted), its(:kms_key_id), its(:dbi_resource_id), its(:ca_certificate_identifier), its(:domain_memberships), its(:copy_tags_to_snapshot), its(:monitoring_interval), its(:enhanced_monitoring_resource_arn), its(:monitoring_role_arn), its(:promotion_tier), its(:db_instance_arn), its(:timezone)
### :unlock: Advanced use

`rds` can use `Aws::RDS::DBInstance` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/RDS/DBInstance.html).

```ruby
describe rds('my-rds') do
  its('db_subnet_group.db_subnet_group_name') { should eq 'my-db-subnet-group' }
end
```

or

```ruby
describe rds('my-rds') do
  its('resource.db_subnet_group.db_subnet_group_name') { should eq 'my-db-subnet-group' }
end
```

## <a name="rds_db_cluster_parameter_group">rds_db_cluster_parameter_group</a>

RdsDbClusterParameterGroup resource type.

```ruby
describe rds_db_cluster_parameter_group('my-rds-db-cluster-parameter-group') do
  its(:time_zone) { should eq 'US/Central' }
  its(:binlog_format) { should eq 'ROW' }
  its(:character_set_server) { should eq 'utf8mb4' }
end
```

### exist

```ruby
describe rds_db_cluster_parameter_group('my-rds-db-cluster-parameter-group') do
  it { should exist }
end
```


## <a name="rds_db_parameter_group">rds_db_parameter_group</a>

RdsDbParameterGroup resource type.

```ruby
describe rds_db_parameter_group('my-rds-db-parameter-group') do
  its(:basedir) { should eq '/rdsdbbin/mysql' }
  its(:innodb_buffer_pool_size) { '{DBInstanceClassMemory*3/4}' }
end
```

### exist

```ruby
describe rds_db_parameter_group('my-rds-db-parameter-group') do
  it { should exist }
end
```


## <a name="route53_hosted_zone">route53_hosted_zone</a>

Route53HostedZone resource type.

### exist

```ruby
describe route53_hosted_zone('example.com.') do
  it { should exist }
end
```


### have_record_set

```ruby
describe route53_hosted_zone('example.com.') do
  its(:resource_record_set_count) { should eq 6 }
  it { should have_record_set('example.com.').a('123.456.7.890') }
  it { should have_record_set('*.example.com.').cname('example.com') }
  it { should have_record_set('example.com.').mx('10 mail.example.com') }
  it { should have_record_set('mail.example.com.').a('123.456.7.890').ttl(3600) }
  ns = 'ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.'
  it { should have_record_set('example.com.').ns(ns) }
  it { should have_record_set('s3.example.com.').alias('s3-website-us-east-1.amazonaws.com.', 'Z2ABCDEFGHIJKL') }
end
```

### its(:id), its(:name), its(:caller_reference), its(:config), its(:resource_record_set_count)
## <a name="route_table">route_table</a>

RouteTable resource type.

### exist

```ruby
describe route_table('my-route-table') do
  it { should exist }
end
```


### have_route

```ruby
describe route_table('my-route-table') do
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_route('0.0.0.0/0').target(gateway: 'igw-1ab2345c') }
  it { should have_route('192.168.1.0/24').target(instance: 'my-ec2') }
  it { should have_route('192.168.2.0/24').target(vpc_peering_connection: 'my-pcx') }
  it { should have_route('192.168.3.0/24').target(nat: 'nat-7ff7777f') }
end
```


### have_subnet

```ruby
describe route_table('my-route-table') do
  it { should have_subnet('my-subnet') }
end
```


### have_tag

```ruby
describe route_table('my-route-table') do
  it { should have_tag('Name').value('my-route-table') }
end
```


### its(:route_table_id), its(:vpc_id), its(:propagating_vgws)
### :unlock: Advanced use

`route_table` can use `Aws::EC2::RouteTable` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/RouteTable.html).

```ruby
describe route_table('my-route-table') do
  its('vpc.id') { should eq 'vpc-ab123cde' }
end
```

or

```ruby
describe s3_bucket('my-bucket') do
  its('resource.vpc.id') { should eq 'vpc-ab123cde' }
end
```

## <a name="s3_bucket">s3_bucket</a>

S3Bucket resource type.

### exist

```ruby
describe s3_bucket('my-bucket') do
  it { should exist }
end
```


### have_acl_grant

```ruby
describe s3_bucket('my-bucket') do
  its(:acl_owner) { should eq 'my-bucket-owner' }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'http://acs.amazonaws.com/groups/s3/LogDelivery', permission: 'WRITE') }
  it { should have_acl_grant(grantee: '68f4bb06b094152df53893bfba57760e', permission: 'READ') }
end
```


### have_cors_rule

```ruby
describe s3_bucket('my-bucket') do
  it do
    should have_cors_rule(
      allowed_methods: ['GET'],
      allowed_origins: ['*']
    )
  end
  it do
    should have_cors_rule(
      allowed_headers: ['*'],
      allowed_methods: ['GET'],
      allowed_origins: ['https://example.org', 'https://example.com'],
      expose_headers:  ['X-Custom-Header'],
      max_age_seconds: 3600
    )
  end
end
```


### have_lifecycle_rule

```ruby
describe s3_bucket('my-bucket') do
  it do
    should have_lifecycle_rule(
      id: 'MyRuleName',
      noncurrent_version_expiration: { noncurrent_days: 1 },
      status: 'Enabled'
    )
  end
end
```


### have_logging_enabled

```ruby
describe s3_bucket('my-bucket') do
  it { should have_logging_enabled(target_bucket: 'my-log-bucket', target_prefix: 'logs/') }
end
```


### have_mfa_delete_enabled

```ruby
describe s3_bucket('my-bucket') do
  it { should have_mfa_delete_enabled }
end
```


### have_object

```ruby
describe s3_bucket('my-bucket') do
  it { should have_object('path/to/object') }
end
```


### have_policy

```ruby
describe s3_bucket('my-bucket') do
  it do
    should have_policy <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
    POLICY
  end
end
```


### have_versioning_enabled

```ruby
describe s3_bucket('my-bucket') do
  it { should have_versioning_enabled }
end
```


### its(:acl_grants_count), its(:acl_owner), its(:cors_rules_count), its(:name), its(:creation_date)
### :unlock: Advanced use

`s3_bucket` can use `Aws::S3::Bucket` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Bucket.html).

```ruby
describe s3_bucket('my-bucket') do
  its('acl.owner.display_name') { should eq 'my-bucket-owner' }
end
```

or

```ruby
describe s3_bucket('my-bucket') do
  its('resource.acl.owner.display_name') { should eq 'my-bucket-owner' }
end
```

## <a name="security_group">security_group</a>

SecurityGroup resource type.

### exist

```ruby
describe security_group('my-security-group-name') do
  it { should exist }
end
```


### be_inbound_opened_only

### be_opened_only

### be_outbound_opened_only

### have_tag

```ruby
describe security_group('my-security-group-name') do
  it { should have_tag('env').value('dev') }
end
```


### its(:inbound), its(:outbound)

```ruby
describe security_group('my-security-group-name') do
  its(:outbound) { should be_opened }
  its(:inbound) { should be_opened(80) }
  its(:inbound) { should be_opened(80).protocol('tcp').for('203.0.113.1/32') }
  its(:inbound) { should be_opened(22).protocol('tcp').for('sg-5a6b7cd8') }
end
```


### its(:inbound_rule_count), its(:outbound_rule_count), its(:inbound_permissions_count), its(:outbound_permissions_count), its(:owner_id), its(:group_name), its(:group_id), its(:description), its(:vpc_id)
### :unlock: Advanced use

`security_group` can use `Aws::EC2::SecurityGroup` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/SecurityGroup.html).

```ruby
describe security_group('my-security-group-name') do
  its('group_name') { should eq 'my-security-group-name' }
end
```

or

```ruby
describe security_group('my-security-group-name') do
  its('resource.group_name') { should eq 'my-security-group-name' }
end
```

## <a name="ses_identity">ses_identity</a>

SesIdentity resource type.

### exist

```ruby
describe ses_identity('example.com') do
  it { should exist }
end
```


### have_dkim_tokens


### have_identity_policy

```ruby
describe ses_identity('example.com') do
  it { should have_identity_policy('my-identity-policy-name') }
end
```

### its(:dkim_enabled), its(:dkim_verification_status), its(:bounce_topic), its(:complaint_topic), its(:delivery_topic), its(:forwarding_enabled), its(:verification_status), its(:verification_token)
## <a name="subnet">subnet</a>

Subnet resource type.

### exist

```ruby
describe subnet('my-subnet') do
  it { should exist }
end
```


### be_associated_to

### be_available, be_pending

```ruby
describe subnet('my-subnet') do
  it { should be_available }
end
```


### have_tag

```ruby
describe subnet('my-subnet') do
  it { should have_tag('Environment').value('QA') }
end
```


### its(:subnet_id), its(:state), its(:vpc_id), its(:cidr_block), its(:ipv_6_cidr_block_association_set), its(:assign_ipv_6_address_on_creation), its(:available_ip_address_count), its(:availability_zone), its(:default_for_az), its(:map_public_ip_on_launch)
### :unlock: Advanced use

`subnet` can use `Aws::EC2::Subnet` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Subnet.html).

```ruby
describe subnet('my-subnet') do
  its('vpc.id') { should eq 'vpc-ab123cde' }
end
```

or

```ruby
describe subnet('my-subnet') do
  its('resource.vpc.id') { should eq 'vpc-ab123cde' }
end
```

## <a name="vpc">vpc</a>

VPC resource type.

### exist

```ruby
describe vpc('my-vpc') do
  it { should exist }
end
```


### be_available, be_pending

```ruby
describe vpc('vpc-ab123cde') do
  it { should be_available }
end
```


### have_network_acl

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_network_acl('acl-1abc2d3e') }
  it { should have_network_acl('my-network-acl') }
end
```


### have_route_table

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_route_table('rtb-ab123cde') }
  it { should have_route_table('my-route-table') }
end
```


### have_tag

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_tag('Stack').value('Networking') }
end
```


### its(:vpc_id), its(:state), its(:cidr_block), its(:dhcp_options_id), its(:instance_tenancy), its(:is_default), its(:ipv_6_cidr_block_association_set)
### :unlock: Advanced use

`vpc` can use `Aws::EC2::Vpc` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Vpc.html).

```ruby
describe vpc('my-vpc') do
  its('route_tables.first.route_table_id') { should eq 'rtb-a12bcd34' }
end
```

or

```ruby
describe vpc('my-vpc') do
  its('resource.route_tables.first.route_table_id') { should eq 'rtb-a12bcd34' }
end
```

## <a name="vpn_connection">vpn_connection</a>

VpnConnection resource type.

### exist

```ruby
describe vpn_connection('my-vpn-connection') do
  it { should exist }
end
```


### be_pending, be_available, be_deleting, be_deleted

```ruby
describe vpn_connection('my-vpn-connection') do
  it { should be_running }
end
```


### have_tag

```ruby
describe vpn_connection('my-vpn-connection') do
  it { should have_tag('Name').value('my-vpn-connection') }
end
```


### its(:vpn_connection_id), its(:state), its(:customer_gateway_configuration), its(:type), its(:customer_gateway_id), its(:vpn_gateway_id), its(:tags), its(:vgw_telemetry), its(:options), its(:routes)
## <a name="vpn_gateway">vpn_gateway</a>

VpnGateway resource type.

### exist

```ruby
describe vpn_gateway('my-vpn-gateway') do
  it { should exist }
end
```


### be_pending, be_available, be_deleting, be_deleted

```ruby
describe vpn_gateway('my-vpn-gateway') do
  it { should be_running }
end
```


### have_tag

```ruby
describe vpn_gateway('my-vpn-gateway') do
  it { should have_tag('Name').value('my-vpn-gateway') }
end
```


### its(:vpn_gateway_id), its(:state), its(:type), its(:availability_zone), its(:vpc_attachments), its(:tags)
## <a name="waf_web_acl">waf_web_acl</a>

WafWebAcl resource type.

### exist

### have_rule

```ruby
describe waf_web_acl('my-waf-web-acl') do
  it { should have_rule('my-waf-web-acl-allowed-ips') }
  it { should have_rule('my-waf-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```


### its(:default_action), its(:web_acl_id), its(:name), its(:metric_name)
# Account and Attributes

## <a name="account">account</a>

Account resource type.

```ruby
describe account do
  its(:user_id) { should eq 'AKIAI44QH8DHBEXAMPLE' }
  its(:account) { should eq '123456789012' }
  its(:arn) { should eq 'arn:aws:iam::123456789012:user/Alice' }
  its('ec2.supported_platforms') { should eq ["EC2", "VPC"] }
  its('ec2.vpc_max_security_groups_per_interface') { should eq 5 }
  its('ec2.max_elastic_ips') { should eq 5 }
  its('ec2.max_instances') { should eq 20 }
  its('ec2.vpc_max_elastic_ips') { should eq 5 }
  its('ec2.default_vpc') { should eq 'none' }
  its('rds.DBInstances.used') { should eq 0 }
  its('rds.DBInstances.max') { should eq 40 }
  its('rds.ReservedDBInstances.used') { should eq 0 }
  its('rds.ReservedDBInstances.max') { should eq 40 }
  its('rds.AllocatedStorage.used') { should eq 0 }
  its('rds.AllocatedStorage.max') { should eq 100000 }
  its('rds.DBSecurityGroups.used') { should eq 0 }
  its('rds.DBSecurityGroups.max') { should eq 25 }
  its('rds.AuthorizationsPerDBSecurityGroup.used') { should eq 0 }
  its('rds.AuthorizationsPerDBSecurityGroup.max') { should eq 20 }
  its('rds.DBParameterGroups.used') { should eq 1 }
  its('rds.DBParameterGroups.max') { should eq 50 }
  its('rds.ManualSnapshots.used') { should eq 0 }
  its('rds.ManualSnapshots.max') { should eq 100 }
  its('rds.EventSubscriptions.used') { should eq 0 }
  its('rds.EventSubscriptions.max') { should eq 20 }
  its('rds.DBSubnetGroups.used') { should eq 1 }
  its('rds.DBSubnetGroups.max') { should eq 50 }
  its('rds.OptionGroups.used') { should eq 0 }
  its('rds.OptionGroups.max') { should eq 20 }
  its('rds.SubnetsPerDBSubnetGroup.used') { should eq 2 }
  its('rds.SubnetsPerDBSubnetGroup.max') { should eq 20 }
  its('rds.ReadReplicasPerMaster.used') { should eq 0 }
  its('rds.ReadReplicasPerMaster.max') { should eq 5 }
  its('rds.DBClusters.used') { should eq 0 }
  its('rds.DBClusters.max') { should eq 40 }
  its('rds.DBClusterParameterGroups.used') { should eq 0 }
  its('rds.DBClusterParameterGroups.max') { should eq 50 }
  its('rds.DBClusterRoles.used') { should eq 0 }
  its('rds.DBClusterRoles.max') { should eq 5 }
  its('lambda.total_code_size.limit') { should eq 80530636800 }
  its('lambda.total_code_size.usage') { should eq 2034651562 }
  its('lambda.code_size_unzipped.limit') { should eq 262144000 }
  its('lambda.code_size_zipped.limit') { should eq 52428800 }
  its('lambda.concurrent_executions.limit') { should eq 200 }
  its('lambda.function_count.usage') { should eq 8 }
  its('ses.max_24_hour_send') { should eq 200.0 }
  its('ses.max_send_rate') { should eq 1.0 }
  its('ses.sent_last_24_hours') { should eq 1.0 }
end
```


## :unlock: Another way: Test with account_attribute type

## <a name="account_attribute">account_attribute</a>

Account Attribute resource type.

```ruby
describe account_attribute('ec2') do
  its('supported_platforms') { should eq ["EC2", "VPC"] }
  its('vpc_max_security_groups_per_interface') { should eq 5 }
  its('max_elastic_ips') { should eq 5 }
  its('max_instances') { should eq 20 }
  its('vpc_max_elastic_ips') { should eq 5 }
  its('default_vpc') { should eq 'none' }
end
 
describe account_attribute('rds') do
  its('DBInstances.used') { should eq 0 }
  its('DBInstances.max') { should eq 40 }
  its('ReservedDBInstances.used') { should eq 0 }
  its('ReservedDBInstances.max') { should eq 40 }
  its('AllocatedStorage.used') { should eq 0 }
  its('AllocatedStorage.max') { should eq 100000 }
  its('DBSecurityGroups.used') { should eq 0 }
  its('DBSecurityGroups.max') { should eq 25 }
  its('AuthorizationsPerDBSecurityGroup.used') { should eq 0 }
  its('AuthorizationsPerDBSecurityGroup.max') { should eq 20 }
  its('DBParameterGroups.used') { should eq 1 }
  its('DBParameterGroups.max') { should eq 50 }
  its('ManualSnapshots.used') { should eq 0 }
  its('ManualSnapshots.max') { should eq 100 }
  its('EventSubscriptions.used') { should eq 0 }
  its('EventSubscriptions.max') { should eq 20 }
  its('DBSubnetGroups.used') { should eq 1 }
  its('DBSubnetGroups.max') { should eq 50 }
  its('OptionGroups.used') { should eq 0 }
  its('OptionGroups.max') { should eq 20 }
  its('SubnetsPerDBSubnetGroup.used') { should eq 2 }
  its('SubnetsPerDBSubnetGroup.max') { should eq 20 }
  its('ReadReplicasPerMaster.used') { should eq 0 }
  its('ReadReplicasPerMaster.max') { should eq 5 }
  its('DBClusters.used') { should eq 0 }
  its('DBClusters.max') { should eq 40 }
  its('DBClusterParameterGroups.used') { should eq 0 }
  its('DBClusterParameterGroups.max') { should eq 50 }
  its('DBClusterRoles.used') { should eq 0 }
  its('DBClusterRoles.max') { should eq 5 }
end
 
describe account_attribute('lambda') do
  its('total_code_size.limit') { should eq 80530636800 }
  its('total_code_size.usage') { should eq 2034651562 }
  its('code_size_unzipped.limit') { should eq 262144000 }
  its('code_size_zipped.limit') { should eq 52428800 }
  its('concurrent_executions.limit') { should eq 200 }
  its('function_count.usage') { should eq 8 }
end
 
describe account_attribute('ses') do
  its('max_24_hour_send') { should eq 200.0 }
  its('max_send_rate') { should eq 1.0 }
  its('sent_last_24_hours') { should eq 1.0 }
end
 
```


## :unlock: Another way: Test with separated resource types

[ec2_account_attributes](#ec2_account_attributes)
| [rds_account_attributes](#rds_account_attributes)
| [lambda_account_settings](#lambda_account_settings)
| [ses_send_quota](#ses_send_quota)
## <a name="ec2_account_attributes">ec2_account_attributes</a>

Ec2AccountAttributes account attributes.

```ruby
describe ec2_account_attributes do
  its(:supported_platforms) { should include 'VPC' }
  its(:max_instances) { should eq 20 }
end
```

### its(:supported_platforms), its(:vpc_max_security_groups_per_interface), its(:max_elastic_ips), its(:max_instances), its(:vpc_max_elastic_ips), its(:default_vpc)
## <a name="rds_account_attributes">rds_account_attributes</a>

RdsAccountAttributes account attributes.

```ruby
describe rds_account_attributes do
  its('DBInstances.used') { should eq 0 }
  its('DBInstances.max') { should eq 40 }
end
```


## <a name="lambda_account_settings">lambda_account_settings</a>

LambdaAccountSettings account attributes.

```ruby
describe lambda_account_settings do
  its('total_code_size.limit') { should eq 80_530_636_800 }
  its('total_code_size.usage') { should eq 2_034_651_562 }
  its('function_count.usage') { should eq 8 }
end
```



## <a name="ses_send_quota">ses_send_quota</a>

SesSendQuota account attributes.

```ruby
describe ses_send_quota do
  its(:max_24_hour_send) { should eq 200.0 }
  its(:max_send_rate) { should eq 1.0 }
  its(:sent_last_24_hours) { should eq 1.0 }
end
```

### its(:max_24_hour_send), its(:max_send_rate), its(:sent_last_24_hours)
