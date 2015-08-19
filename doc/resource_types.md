# Resource Types

[ec2](#ec2)|[rds](#rds)|[rds_db_parameter_group](#rds_db_parameter_group)|[security_group](#security_group)|[vpc](#vpc)|[s3](#s3)|[route53_hosted_zone](#route53_hosted_zone)|[auto_scaling_group](#auto_scaling_group)|[subnet](#subnet)|[route_table](#route_table)|[ebs](#ebs)

## <a name="ec2">ec2</a>

EC2 resource type.

### exist

### be_stopped

### be_pending

### be_running

### be_shutting_down

### be_terminated

### be_stopping

### have_security_group

### have_eip

### have_ebs

### belong_to_subnet

### belong_to_vpc

#### its(:instance_id), its(:image_id), its(:state), its(:private_dns_name), its(:public_dns_name), its(:state_transition_reason), its(:key_name), its(:ami_launch_index), its(:instance_type), its(:launch_time), its(:placement), its(:kernel_id), its(:ramdisk_id), its(:platform), its(:monitoring), its(:subnet_id), its(:vpc_id), its(:private_ip_address), its(:public_ip_address), its(:state_reason), its(:architecture), its(:root_device_type), its(:root_device_name), its(:virtualization_type), its(:instance_lifecycle), its(:spot_instance_request_id), its(:client_token), its(:source_dest_check), its(:hypervisor), its(:iam_instance_profile), its(:ebs_optimized), its(:sriov_net_support)
## <a name="rds">rds</a>

RDS resource type.

### exist

### be_upgrading

### be_storage_full

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

### be_restore_error

### be_maintenance

### be_modifying

### be_rebooting

### be_renaming

### be_resetting_master_credentials

### be_incompatible_restore

### have_db_parameter_group

### have_option_group

### have_security_group

### belong_to_db_subnet_group

### belong_to_subnet

### belong_to_vpc

#### its(:vpc_id), its(:db_instance_identifier), its(:db_instance_class), its(:engine), its(:db_instance_status), its(:master_username), its(:db_name), its(:endpoint), its(:allocated_storage), its(:instance_create_time), its(:preferred_backup_window), its(:backup_retention_period), its(:availability_zone), its(:db_subnet_group), its(:preferred_maintenance_window), its(:pending_modified_values), its(:latest_restorable_time), its(:multi_az), its(:engine_version), its(:auto_minor_version_upgrade), its(:read_replica_source_db_instance_identifier), its(:license_model), its(:iops), its(:character_set_name), its(:secondary_availability_zone), its(:publicly_accessible), its(:storage_type), its(:tde_credential_arn), its(:db_instance_port), its(:db_cluster_identifier), its(:storage_encrypted), its(:kms_key_id), its(:dbi_resource_id), its(:ca_certificate_identifier)
## <a name="rds_db_parameter_group">rds_db_parameter_group</a>

RdsDbParameterGroup resource type.

### exist


## <a name="security_group">security_group</a>

SecurityGroup resource type.

### exist

### its(:inbound), its(:outbound)

#### its(:ip_permissions_count), its(:ip_permissions_egress_count), its(:owner_id), its(:group_name), its(:group_id), its(:description), its(:vpc_id)
## <a name="vpc">vpc</a>

VPC resource type.

### exist

### be_pending

### be_available

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

### be_pending

### be_available

#### its(:subnet_id), its(:state), its(:vpc_id), its(:cidr_block), its(:available_ip_address_count), its(:availability_zone), its(:default_for_az), its(:map_public_ip_on_launch)
## <a name="route_table">route_table</a>

RouteTable resource type.

### exist

### have_route

#### its(:route_table_id), its(:vpc_id)
## <a name="ebs">ebs</a>

EBS resource type.

### exist

### be_deleted

### be_in_use

### be_deleting

### be_available

### be_error

### be_attached_to

### be_creating

#### its(:volume_id), its(:size), its(:snapshot_id), its(:availability_zone), its(:state), its(:create_time), its(:volume_type), its(:iops), its(:encrypted), its(:kms_key_id)
