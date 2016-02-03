# Resource Types

[ami](#ami)
| [autoscaling_group](#autoscaling_group)
| [cloudwatch_alarm](#cloudwatch_alarm)
| [directconnect_virtual_interface](#directconnect_virtual_interface)
| [ebs](#ebs)
| [ec2](#ec2)
| [elasticache](#elasticache)
| [elasticache_cache_parameter_group](#elasticache_cache_parameter_group)
| [elb](#elb)
| [iam_group](#iam_group)
| [iam_policy](#iam_policy)
| [iam_role](#iam_role)
| [iam_user](#iam_user)
| [lambda](#lambda)
| [launch_configuration](#launch_configuration)
| [nat_gateway](#nat_gateway)
| [network_acl](#network_acl)
| [rds](#rds)
| [rds_db_parameter_group](#rds_db_parameter_group)
| [route53_hosted_zone](#route53_hosted_zone)
| [route_table](#route_table)
| [s3_bucket](#s3_bucket)
| [security_group](#security_group)
| [ses_identity](#ses_identity)
| [subnet](#subnet)
| [vpc](#vpc)

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


### its(:image_id), its(:image_location), its(:state), its(:owner_id), its(:creation_date), its(:public), its(:architecture), its(:image_type), its(:kernel_id), its(:ramdisk_id), its(:platform), its(:sriov_net_support), its(:state_reason), its(:image_owner_alias), its(:name), its(:description), its(:root_device_type), its(:root_device_name), its(:virtualization_type), its(:hypervisor)
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

### its(:auto_scaling_group_name), its(:auto_scaling_group_arn), its(:launch_configuration_name), its(:min_size), its(:max_size), its(:desired_capacity), its(:default_cooldown), its(:health_check_type), its(:health_check_grace_period), its(:created_time), its(:placement_group), its(:vpc_zone_identifier), its(:status), its(:new_instances_protected_from_scale_in)
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

### its(:alarm_name), its(:alarm_arn), its(:alarm_description), its(:alarm_configuration_updated_timestamp), its(:actions_enabled), its(:state_value), its(:state_reason), its(:state_reason_data), its(:state_updated_timestamp), its(:metric_name), its(:namespace), its(:statistic), its(:period), its(:unit), its(:evaluation_periods), its(:threshold), its(:comparison_operator)
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

### its(:owner_account), its(:virtual_interface_id), its(:location), its(:connection_id), its(:virtual_interface_type), its(:virtual_interface_name), its(:vlan), its(:asn), its(:auth_key), its(:amazon_address), its(:customer_address), its(:virtual_interface_state), its(:customer_router_config), its(:virtual_gateway_id)
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


### have_security_group

```ruby
describe ec2('my-ec2') do
  it { should have_security_group('my-security-group-name') }
  it { should have_security_group('sg-1a2b3cd4') }
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


### its(:instance_id), its(:image_id), its(:private_dns_name), its(:public_dns_name), its(:state_transition_reason), its(:key_name), its(:ami_launch_index), its(:instance_type), its(:launch_time), its(:placement), its(:kernel_id), its(:ramdisk_id), its(:platform), its(:monitoring), its(:subnet_id), its(:vpc_id), its(:private_ip_address), its(:public_ip_address), its(:state_reason), its(:architecture), its(:root_device_type), its(:root_device_name), its(:virtualization_type), its(:instance_lifecycle), its(:spot_instance_request_id), its(:client_token), its(:source_dest_check), its(:hypervisor), its(:iam_instance_profile), its(:ebs_optimized), its(:sriov_net_support)
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

### its(:cache_cluster_id), its(:configuration_endpoint), its(:client_download_landing_page), its(:cache_node_type), its(:engine), its(:engine_version), its(:cache_cluster_status), its(:num_cache_nodes), its(:preferred_availability_zone), its(:cache_cluster_create_time), its(:preferred_maintenance_window), its(:notification_configuration), its(:cache_subnet_group_name), its(:auto_minor_version_upgrade), its(:replication_group_id), its(:snapshot_retention_limit), its(:snapshot_window)
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

### its(:health_check_target), its(:health_check_interval), its(:health_check_timeout), its(:health_check_unhealthy_threshold), its(:health_check_healthy_threshold), its(:load_balancer_name), its(:dns_name), its(:canonical_hosted_zone_name), its(:canonical_hosted_zone_name_id), its(:vpc_id), its(:created_time), its(:scheme)
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

### its(:path), its(:group_name), its(:group_id), its(:arn), its(:create_date)
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
describe iam_policy('my-iam-policy') do
  it { should be_attached_to_policy('my-iam-policy') }
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

### its(:path), its(:role_name), its(:role_id), its(:arn), its(:create_date), its(:assume_role_policy_document)
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


### belong_to_iam_group

```ruby
describe iam_user('my-iam-user') do
  it { should belong_to_iam_group('my-iam-group') }
end
```

### its(:path), its(:user_name), its(:user_id), its(:arn), its(:create_date), its(:password_last_used)
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

### its(:function_name), its(:function_arn), its(:runtime), its(:role), its(:handler), its(:code_size), its(:description), its(:timeout), its(:memory_size), its(:last_modified), its(:code_sha_256), its(:version)
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

### its(:launch_configuration_name), its(:launch_configuration_arn), its(:image_id), its(:key_name), its(:classic_link_vpc_id), its(:user_data), its(:instance_type), its(:kernel_id), its(:ramdisk_id), its(:spot_price), its(:iam_instance_profile), its(:created_time), its(:ebs_optimized), its(:associate_public_ip_address), its(:placement_tenancy)
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

### its(:vpc_id), its(:subnet_id), its(:nat_gateway_id), its(:create_time), its(:delete_time), its(:state), its(:failure_code), its(:failure_message)
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
  it { should belong_to_db_subnet_group('my-db-subnet-group') }
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


### its(:vpc_id), its(:db_instance_identifier), its(:db_instance_class), its(:engine), its(:db_instance_status), its(:master_username), its(:db_name), its(:endpoint), its(:allocated_storage), its(:instance_create_time), its(:preferred_backup_window), its(:backup_retention_period), its(:availability_zone), its(:preferred_maintenance_window), its(:pending_modified_values), its(:latest_restorable_time), its(:multi_az), its(:engine_version), its(:auto_minor_version_upgrade), its(:read_replica_source_db_instance_identifier), its(:license_model), its(:iops), its(:character_set_name), its(:secondary_availability_zone), its(:publicly_accessible), its(:storage_type), its(:tde_credential_arn), its(:db_instance_port), its(:db_cluster_identifier), its(:storage_encrypted), its(:kms_key_id), its(:dbi_resource_id), its(:ca_certificate_identifier), its(:copy_tags_to_snapshot), its(:monitoring_interval), its(:enhanced_monitoring_resource_arn), its(:monitoring_role_arn)
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


### its(:route_table_id), its(:vpc_id)
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


### have_object

```ruby
describe s3_bucket('my-bucket') do
  it { should have_object('path/to/object') }
end
```


### have_policy

```ruby
describe s3_bucket('my-bucket') do
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


### be_available, be_pending

```ruby
describe subnet('my-subnet') do
  it { should be_available }
end
```


### its(:subnet_id), its(:state), its(:vpc_id), its(:cidr_block), its(:available_ip_address_count), its(:availability_zone), its(:default_for_az), its(:map_public_ip_on_launch)
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


### its(:vpc_id), its(:state), its(:cidr_block), its(:dhcp_options_id), its(:instance_tenancy), its(:is_default)
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
