# Resource Types

[ec2](#ec2)
| [rds](#rds)
| [rds_db_parameter_group](#rds_db_parameter_group)
| [security_group](#security_group)
| [vpc](#vpc)
| [s3](#s3)
| [route53_hosted_zone](#route53_hosted_zone)
| [auto_scaling_group](#auto_scaling_group)
| [subnet](#subnet)
| [route_table](#route_table)
| [ebs](#ebs)
| [elb](#elb)
| [lambda](#lambda)
| [iam_user](#iam_user)
| [iam_group](#iam_group)
| [iam_role](#iam_role)
| [iam_policy](#iam_policy)
| [elasticache](#elasticache)
| [elasticache_cache_parameter_group](#elasticache_cache_parameter_group)
| [cloudwatch_alarm](#cloudwatch_alarm)
| [ses_identity](#ses_identity)

## <a name="ec2">ec2</a>

EC2 resource type.

### exist

```ruby
describe ec2('my-ec2') do
  it { should exist }
end
```


### be_disabled_api_termination

### be_pending

### be_running

```ruby
describe ec2('my-ec2') do
  it { should be_running }
end
```

### be_shutting_down

### be_stopped

### be_stopping

### be_terminated

### have_ebs

### have_eip

### have_security_group

### belong_to_subnet

### belong_to_vpc

#### its(:instance_id), its(:image_id), its(:private_dns_name), its(:public_dns_name), its(:state_transition_reason), its(:key_name), its(:ami_launch_index), its(:instance_type), its(:launch_time), its(:placement), its(:kernel_id), its(:ramdisk_id), its(:platform), its(:monitoring), its(:subnet_id), its(:vpc_id), its(:private_ip_address), its(:public_ip_address), its(:state_reason), its(:architecture), its(:root_device_type), its(:root_device_name), its(:virtualization_type), its(:instance_lifecycle), its(:spot_instance_request_id), its(:client_token), its(:source_dest_check), its(:hypervisor), its(:iam_instance_profile), its(:ebs_optimized), its(:sriov_net_support)
## <a name="rds">rds</a>

RDS resource type.

### exist

### be_available

### be_backing_up

### be_creating

### be_deleting

### be_failed

### be_inaccessible_encryption_credentials

### be_incompatible_credentials

### be_incompatible_network

### be_incompatible_option_group

### be_incompatible_parameters

### be_incompatible_restore

### be_maintenance

### be_modifying

### be_rebooting

### be_renaming

### be_resetting_master_credentials

### be_restore_error

### be_storage_full

### be_upgrading

### have_db_parameter_group

### have_option_group

### have_security_group

### belong_to_db_subnet_group

### belong_to_subnet

### belong_to_vpc

#### its(:vpc_id), its(:db_instance_identifier), its(:db_instance_class), its(:engine), its(:db_instance_status), its(:master_username), its(:db_name), its(:endpoint), its(:allocated_storage), its(:instance_create_time), its(:preferred_backup_window), its(:backup_retention_period), its(:availability_zone), its(:preferred_maintenance_window), its(:pending_modified_values), its(:latest_restorable_time), its(:multi_az), its(:engine_version), its(:auto_minor_version_upgrade), its(:read_replica_source_db_instance_identifier), its(:license_model), its(:iops), its(:character_set_name), its(:secondary_availability_zone), its(:publicly_accessible), its(:storage_type), its(:tde_credential_arn), its(:db_instance_port), its(:db_cluster_identifier), its(:storage_encrypted), its(:kms_key_id), its(:dbi_resource_id), its(:ca_certificate_identifier)
## <a name="rds_db_parameter_group">rds_db_parameter_group</a>

RdsDbParameterGroup resource type.

```ruby
describe rds_db_parameter_group('my-rds-db-parameter-group') do
  its(:basedir) { should eq '/rdsdbbin/mysql' }
  its(:innodb_buffer_pool_size) { '{DBInstanceClassMemory*3/4}' }
end
```

### exist


## <a name="security_group">security_group</a>

SecurityGroup resource type.

### exist

### its(:inbound), its(:outbound)

```ruby
describe security_group('my-security-group-name') do
  its(:outbound) { should be_opened }
  its(:inbound) { should be_opened(80) }
  its(:inbound) { should be_opened(80).protocol('tcp').for('203.0.113.1/32') }
  its(:inbound) { should be_opened(22).protocol('tcp').for('sg-5a6b7cd8') }
end
```

#### its(:ip_permissions_count), its(:ip_permissions_egress_count), its(:owner_id), its(:group_name), its(:group_id), its(:description), its(:vpc_id)
## <a name="vpc">vpc</a>

VPC resource type.

### exist

### be_available

### be_pending

### have_network_acl

### have_route_table

#### its(:vpc_id), its(:state), its(:cidr_block), its(:dhcp_options_id), its(:instance_tenancy), its(:is_default)
## <a name="s3">s3</a>

S3 resource type.

### exist

### have_object

#### its(:name), its(:creation_date)
## <a name="route53_hosted_zone">route53_hosted_zone</a>

Route53HostedZone resource type.

### exist

### have_record_set

#### its(:id), its(:name), its(:caller_reference), its(:config), its(:resource_record_set_count)
## <a name="auto_scaling_group">auto_scaling_group</a>

AutoScalingGroup resource type.

### exist

### have_ec2

### have_elb

#### its(:auto_scaling_group_name), its(:auto_scaling_group_arn), its(:launch_configuration_name), its(:min_size), its(:max_size), its(:desired_capacity), its(:default_cooldown), its(:health_check_type), its(:health_check_grace_period), its(:created_time), its(:placement_group), its(:vpc_zone_identifier), its(:status)
## <a name="subnet">subnet</a>

Subnet resource type.

### exist

### be_available

### be_pending

#### its(:subnet_id), its(:state), its(:vpc_id), its(:cidr_block), its(:available_ip_address_count), its(:availability_zone), its(:default_for_az), its(:map_public_ip_on_launch)
## <a name="route_table">route_table</a>

RouteTable resource type.

### exist

### have_route

#### its(:route_table_id), its(:vpc_id)
## <a name="ebs">ebs</a>

EBS resource type.

### exist

### be_attached_to

### be_available

### be_creating

### be_deleted

### be_deleting

### be_error

### be_in_use

#### its(:volume_id), its(:size), its(:snapshot_id), its(:availability_zone), its(:state), its(:create_time), its(:volume_type), its(:iops), its(:encrypted), its(:kms_key_id)
## <a name="elb">elb</a>

ELB resource type.

### exist

### have_ec2

### have_listener

http://docs.aws.amazon.com/en_us/ElasticLoadBalancing/latest/DeveloperGuide/elb-listener-config.html

```ruby
describe elb('my-elb') do
  it { should have_listener(protocol: 'HTTPS', port: 443, instance_protocol: 'HTTP', instance_port: 80) }
end
```

### have_security_group

### have_subnet

### belong_to_subnet

### belong_to_vpc

#### its(:health_check_target), its(:health_check_interval), its(:health_check_timeout), its(:health_check_unhealthy_threshold), its(:health_check_healthy_threshold), its(:load_balancer_name), its(:dns_name), its(:canonical_hosted_zone_name), its(:canonical_hosted_zone_name_id), its(:vpc_id), its(:created_time), its(:scheme)
## <a name="lambda">lambda</a>

Lambda resource type.

### exist

### have_event_source

This matcher does not support Amazon S3 event sources. ( [See SDK doc](http://docs.aws.amazon.com/sdkforruby/api/Aws/Lambda/Client.html#list_event_source_mappings-instance_method) )

#### its(:function_name), its(:function_arn), its(:runtime), its(:role), its(:handler), its(:code_size), its(:description), its(:timeout), its(:memory_size), its(:last_modified)
## <a name="iam_user">iam_user</a>

IamUser resource type.

### exist

### be_allowed_action

```ruby
describe iam_user('my-iam-user') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```

### have_iam_policy

### belong_to_iam_group

#### its(:path), its(:user_name), its(:user_id), its(:arn), its(:create_date), its(:password_last_used)
## <a name="iam_group">iam_group</a>

IamGroup resource type.

### exist

### be_allowed_action

```ruby
describe iam_group('my-iam-group') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```

### have_iam_policy

### have_iam_user

#### its(:path), its(:group_name), its(:group_id), its(:arn), its(:create_date)
## <a name="iam_role">iam_role</a>

IamRole resource type.

### exist

### be_allowed_action

```ruby
describe iam_role('my-iam-role') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```

### have_iam_policy

#### its(:path), its(:role_name), its(:role_id), its(:arn), its(:create_date), its(:assume_role_policy_document)
## <a name="iam_policy">iam_policy</a>

IamPolicy resource type.

### exist

### be_attachable

### be_attached_to_group

### be_attached_to_role

### be_attached_to_user

#### its(:policy_name), its(:policy_id), its(:arn), its(:path), its(:default_version_id), its(:attachment_count), its(:is_attachable), its(:description), its(:create_date), its(:update_date)
## <a name="elasticache">elasticache</a>

Elasticache resource type.

### exist

### be_available

### be_creating

### be_deleted

### be_deleting

### be_incompatible_network

### be_modifying

### be_rebooting_cache_cluster_nodes

### be_restore_failed

### be_snapshotting

### have_cache_parameter_group

### belong_to_cache_subnet_group

### belong_to_replication_group

### belong_to_vpc

#### its(:cache_cluster_id), its(:configuration_endpoint), its(:client_download_landing_page), its(:cache_node_type), its(:engine), its(:engine_version), its(:cache_cluster_status), its(:num_cache_nodes), its(:preferred_availability_zone), its(:cache_cluster_create_time), its(:preferred_maintenance_window), its(:notification_configuration), its(:cache_subnet_group_name), its(:auto_minor_version_upgrade), its(:replication_group_id), its(:snapshot_retention_limit), its(:snapshot_window)
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


## <a name="cloudwatch_alarm">cloudwatch_alarm</a>

CloudwatchAlarm resource type.

### exist

### have_alarm_action

### have_insufficient_data_action

### have_ok_action

### belong_to_metric

#### its(:alarm_name), its(:alarm_arn), its(:alarm_description), its(:alarm_configuration_updated_timestamp), its(:actions_enabled), its(:state_value), its(:state_reason), its(:state_reason_data), its(:state_updated_timestamp), its(:metric_name), its(:namespace), its(:statistic), its(:period), its(:unit), its(:evaluation_periods), its(:threshold), its(:comparison_operator)
## <a name="ses_identity">ses_identity</a>

SesIdentity resource type.

### exist

### have_dkim_tokens

### have_identity_policy

#### its(:dkim_enabled), its(:dkim_verification_status), its(:bounce_topic), its(:complaint_topic), its(:delivery_topic), its(:forwarding_enabled), its(:verification_status), its(:verification_token)
