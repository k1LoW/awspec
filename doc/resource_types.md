# Resource Types

[acm](#acm)
| [alb](#alb)
| [alb_listener](#alb_listener)
| [alb_target_group](#alb_target_group)
| [ami](#ami)
| [apigateway](#apigateway)
| [autoscaling_group](#autoscaling_group)
| [batch_compute_environment](#batch_compute_environment)
| [batch_job_definition](#batch_job_definition)
| [batch_job_queue](#batch_job_queue)
| [cloudformation_stack](#cloudformation_stack)
| [cloudfront_distribution](#cloudfront_distribution)
| [cloudtrail](#cloudtrail)
| [cloudwatch_alarm](#cloudwatch_alarm)
| [cloudwatch_event](#cloudwatch_event)
| [cloudwatch_logs](#cloudwatch_logs)
| [codebuild](#codebuild)
| [codedeploy](#codedeploy)
| [codedeploy_deployment_group](#codedeploy_deployment_group)
| [cognito_identity_pool](#cognito_identity_pool)
| [cognito_user_pool](#cognito_user_pool)
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
| [eip](#eip)
| [eks](#eks)
| [elasticache](#elasticache)
| [elasticache_cache_parameter_group](#elasticache_cache_parameter_group)
| [elasticsearch](#elasticsearch)
| [elastictranscoder_pipeline](#elastictranscoder_pipeline)
| [elb](#elb)
| [emr](#emr)
| [firehose](#firehose)
| [iam_group](#iam_group)
| [iam_policy](#iam_policy)
| [iam_role](#iam_role)
| [iam_user](#iam_user)
| [internet_gateway](#internet_gateway)
| [kinesis](#kinesis)
| [kms](#kms)
| [lambda](#lambda)
| [launch_configuration](#launch_configuration)
| [launch_template](#launch_template)
| [mq](#mq)
| [msk](#msk)
| [nat_gateway](#nat_gateway)
| [network_acl](#network_acl)
| [network_interface](#network_interface)
| [nlb](#nlb)
| [nlb_listener](#nlb_listener)
| [nlb_target_group](#nlb_target_group)
| [rds](#rds)
| [rds_db_cluster_parameter_group](#rds_db_cluster_parameter_group)
| [rds_db_parameter_group](#rds_db_parameter_group)
| [redshift](#redshift)
| [redshift_cluster_parameter_group](#redshift_cluster_parameter_group)
| [route53_hosted_zone](#route53_hosted_zone)
| [route_table](#route_table)
| [s3_bucket](#s3_bucket)
| [secretsmanager](#secretsmanager)
| [security_group](#security_group)
| [ses_identity](#ses_identity)
| [sns_topic](#sns_topic)
| [sqs](#sqs)
| [ssm_parameter](#ssm_parameter)
| [subnet](#subnet)
| [transit_gateway](#transit_gateway)
| [vpc](#vpc)
| [vpc_endpoints](#vpc_endpoints)
| [vpn_connection](#vpn_connection)
| [vpn_gateway](#vpn_gateway)
| [waf_web_acl](#waf_web_acl)
| [wafregional_web_acl](#wafregional_web_acl)
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

### have_domain_name

### have_domain_validation_option

```ruby
describe acm('example.com') do
  it { should have_domain_validation_option(domain_name: 'example.com', validation_method: 'DNS', validation_status: 'SUCCESS') }
  it { should have_domain_validation_option(domain_name: 'mail.example.com', validation_method: 'EMAIL') }
end
```

### its(:certificate_arn), its(:domain_name), its(:subject_alternative_names), its(:serial), its(:subject), its(:issuer), its(:created_at), its(:issued_at), its(:imported_at), its(:status), its(:revoked_at), its(:revocation_reason), its(:not_before), its(:not_after), its(:key_algorithm), its(:signature_algorithm), its(:in_use_by), its(:failure_reason), its(:type), its(:renewal_summary), its(:key_usages), its(:extended_key_usages), its(:certificate_authority_arn), its(:renewal_eligibility), its(:options)
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


### have_subnet

```ruby
describe alb('my-alb') do
  it { should have_subnet('subnet-1234a567') }
end
```


### have_tag

```ruby
describe alb('my-alb') do
  it { should have_tag('environment').value('dev') }
end
```


### belong_to_vpc

```ruby
describe alb('my-alb') do
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:load_balancer_arn), its(:dns_name), its(:canonical_hosted_zone_id), its(:created_time), its(:load_balancer_name), its(:scheme), its(:vpc_id), its(:type), its(:security_groups), its(:ip_address_type)
## <a name="alb_listener">alb_listener</a>

AlbListener resource type.

### exist

```ruby
describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
end
```


### have_rule

```ruby
describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/9683b2d02a6cabee') }
  it do
    should have_rule.priority('10')
      .conditions(field: 'path-pattern', values: ['/img/*'])
      .actions(target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067', type: 'forward')
  end
  it do
    should have_rule.priority('10')
      .if(field: 'path-pattern', values: ['/img/*'])
      .then(target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067', type: 'forward')
  end
  it { should have_rule.conditions([{ field: 'path-pattern', values: ['/admin/*'] }, { field: 'host-header', values: ['admin.example.com'] }]) }
  it { should have_rule.actions(target_group_name: 'my-alb-target-group', type: 'forward') }
end
```

### its(:listener_arn), its(:load_balancer_arn), its(:port), its(:protocol), its(:certificates), its(:ssl_policy), its(:alpn_policy)
## <a name="alb_target_group">alb_target_group</a>

AlbTargetGroup resource type.

### exist

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should exist }
  its(:health_check_path) { should eq '/' }
  its(:health_check_port) { should eq 'traffic-port' }
  its(:health_check_protocol) { should eq 'HTTP' }
end
```


### have_ec2

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should have_ec2('my-ec2') }
end
```


### belong_to_alb

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should belong_to_alb('my-alb') }
end
```


### belong_to_vpc

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should belong_to_vpc('my-vpc') }
end
```


### its(:target_group_arn), its(:target_group_name), its(:protocol), its(:port), its(:vpc_id), its(:health_check_protocol), its(:health_check_port), its(:health_check_enabled), its(:health_check_interval_seconds), its(:health_check_timeout_seconds), its(:healthy_threshold_count), its(:unhealthy_threshold_count), its(:health_check_path), its(:load_balancer_arns), its(:target_type)
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


### have_tag

### its(:architecture), its(:creation_date), its(:image_id), its(:image_location), its(:image_type), its(:public), its(:kernel_id), its(:owner_id), its(:platform), its(:platform_details), its(:usage_operation), its(:ramdisk_id), its(:state), its(:description), its(:ena_support), its(:hypervisor), its(:image_owner_alias), its(:name), its(:root_device_name), its(:root_device_type), its(:sriov_net_support), its(:state_reason), its(:virtualization_type)
### :unlock: Advanced use

`ami` can use `Aws::EC2::Image` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Image.html).

## <a name="apigateway">apigateway</a>

Apigateway resource type.

### exist

```ruby
describe apigateway('my-apigateway') do
  it { should exist }
end
```

### have_integration_method

### have_integration_path

### have_method

### have_path

### its(:id), its(:name), its(:description), its(:created_date), its(:version), its(:warnings), its(:binary_media_types), its(:minimum_compression_size), its(:api_key_source), its(:policy), its(:tags)
## <a name="autoscaling_group">autoscaling_group</a>

AutoscalingGroup resource type.

### exist

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should exist }
end
```


### have_alb_target_group

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_alb_target_group('my-alb-target-group') }
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


### have_launch_configuration

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_launch_configuration('my-lc') }
end
```


### have_nlb_target_group

### have_suspended_process

### have_tag

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_tag('Name').value('my-group') }
end
```

### its(:auto_scaling_group_name), its(:auto_scaling_group_arn), its(:launch_configuration_name), its(:launch_template), its(:mixed_instances_policy), its(:min_size), its(:max_size), its(:desired_capacity), its(:default_cooldown), its(:availability_zones), its(:load_balancer_names), its(:target_group_arns), its(:health_check_type), its(:health_check_grace_period), its(:created_time), its(:placement_group), its(:vpc_zone_identifier), its(:enabled_metrics), its(:status), its(:termination_policies), its(:new_instances_protected_from_scale_in), its(:service_linked_role_arn), its(:max_instance_lifetime)
## <a name="batch_compute_environment">batch_compute_environment</a>

BatchComputeEnvironment resource type.

### exist

```ruby
describe batch_compute_environment('my-batch-compute-environment') do
  it { should exist }
end
```


### be_disabled

### be_enabled

### be_enabled, be_disabled

```ruby
describe batch_compute_environment('my-batch-compute-environment') do
  it { should be_enabled }
end
```


### be_managed

### be_managed, be_unmanaged

```ruby
describe batch_compute_environment('my-batch-compute-environment') do
  it { should be_managed }
end
```

### be_unmanaged

### its(:compute_environment_name), its(:compute_environment_arn), its(:ecs_cluster_arn), its(:type), its(:state), its(:status), its(:status_reason), its(:service_role)
## <a name="batch_job_definition">batch_job_definition</a>

BatchJobDefinition resource type.

### exist

```ruby
describe batch_job_definition('my-batch-job-definition') do
  it { should exist }
end
```

### its(:job_definition_name), its(:job_definition_arn), its(:revision), its(:status), its(:type), its(:parameters), its(:retry_strategy), its(:timeout), its(:node_properties)
## <a name="batch_job_queue">batch_job_queue</a>

BatchJobQueue resource type.

### exist

```ruby
describe batch_job_queue('my-batch-job-queue') do
  it { should exist }
end
```


### be_disabled

### be_enabled

### have_compute_environment_order

```ruby
describe batch_job_queue('my-batch-job-queue') do
  it { should have_compute_environment_order('arn:aws:batch:us-east-1:012345678910:compute-environment/C4OnDemand', 1) }
end
```

### its(:job_queue_name), its(:job_queue_arn), its(:state), its(:status), its(:status_reason), its(:priority)
## <a name="cloudformation_stack">cloudformation_stack</a>

CloudformationStack resource type.

### exist

```ruby
describe cloudformation_stack('my-cloudformation-stack') do
  it { should exist }
  its(:stack_status) { should eq 'UPDATE_COMPLETE' }
end
```

### its(:stack_id), its(:stack_name), its(:change_set_id), its(:description), its(:parameters), its(:creation_time), its(:deletion_time), its(:last_updated_time), its(:rollback_configuration), its(:stack_status), its(:stack_status_reason), its(:disable_rollback), its(:notification_arns), its(:timeout_in_minutes), its(:capabilities), its(:role_arn), its(:enable_termination_protection), its(:parent_id), its(:root_id), its(:drift_information)
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


### have_custom_response_error_code

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it do
    should have_custom_response_error_code(400)
      .error_caching_min_ttl(60)
      .response_page_path('/path/to/400.html')
      .response_code(400)
  end
  it do
    should have_custom_response_error_code(403)
      .error_caching_min_ttl(60)
      .response_page_path('/path/to/403.html')
      .response_code('403')
  end
  it do
    should have_custom_response_error_code(500)
      .error_caching_min_ttl(60)
  end
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

### its(:id), its(:arn), its(:status), its(:last_modified_time), its(:domain_name), its(:origin_groups), its(:comment), its(:price_class), its(:enabled), its(:web_acl_id), its(:http_version), its(:is_ipv6_enabled), its(:alias_icp_recordals)
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


### have_tag

```ruby
describe cloudtrail('my-trail') do
  it { should have_tag('Name').value('my-trail') }
end
```

### its(:name), its(:s3_bucket_name), its(:s3_key_prefix), its(:sns_topic_name), its(:sns_topic_arn), its(:include_global_service_events), its(:is_multi_region_trail), its(:home_region), its(:trail_arn), its(:log_file_validation_enabled), its(:cloud_watch_logs_log_group_arn), its(:cloud_watch_logs_role_arn), its(:kms_key_id), its(:has_custom_event_selectors), its(:has_insight_selectors), its(:is_organization_trail)
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

### its(:alarm_name), its(:alarm_arn), its(:alarm_description), its(:alarm_configuration_updated_timestamp), its(:actions_enabled), its(:ok_actions), its(:alarm_actions), its(:insufficient_data_actions), its(:state_value), its(:state_reason), its(:state_reason_data), its(:state_updated_timestamp), its(:metric_name), its(:namespace), its(:statistic), its(:extended_statistic), its(:period), its(:unit), its(:evaluation_periods), its(:datapoints_to_alarm), its(:threshold), its(:comparison_operator), its(:treat_missing_data), its(:evaluate_low_sample_count_percentile), its(:metrics), its(:threshold_metric_id)
## <a name="cloudwatch_event">cloudwatch_event</a>

CloudwatchEvent resource type.

### exist

### be_enable

### be_scheduled

### its(:name), its(:arn), its(:event_pattern), its(:state), its(:description), its(:schedule_expression), its(:role_arn), its(:managed_by), its(:event_bus_name)
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


### have_tag

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_tag('Name').value('my-cloudwatch-logs-group') }
end
```

### its(:log_group_name), its(:creation_time), its(:retention_in_days), its(:metric_filter_count), its(:arn), its(:stored_bytes), its(:kms_key_id)
## <a name="codebuild">codebuild</a>

Codebuild resource type.

### exist


## <a name="codedeploy">codedeploy</a>

Codedeploy resource type.

### exist

### its(:application_id), its(:application_name), its(:create_time), its(:linked_to_git_hub), its(:git_hub_account_name), its(:compute_platform)
## <a name="codedeploy_deployment_group">codedeploy_deployment_group</a>

CodedeployDeploymentGroup resource type.

### exist

You can set the `application_name` (default: `default`).

```ruby
describe codedeploy_deployment_group('my-codedeploy-deployment-group'), application_name: 'my-codedeploy-application' do
  it { should exist }
end
```


### have_autoscaling_group

```ruby
describe codedeploy_deployment_group('my-codedeploy-deployment-group'), application_name: 'my-codedeploy-application' do
  it { should have_autoscaling_group('my-autoscaling-group') }
end
```

### its(:application_name), its(:deployment_group_id), its(:deployment_group_name), its(:deployment_config_name), its(:on_premises_instance_tag_filters), its(:service_role_arn), its(:target_revision), its(:trigger_configurations), its(:alarm_configuration), its(:deployment_style), its(:load_balancer_info), its(:last_successful_deployment), its(:last_attempted_deployment), its(:ec2_tag_set), its(:on_premises_tag_set), its(:compute_platform), its(:ecs_services)
## <a name="cognito_identity_pool">cognito_identity_pool</a>

CognitoIdentityPool resource type.

### exist

```ruby
describe cognito_identity_pool('my-cognito-identity-pool') do
  it { should exist }
end
```
### its(:identity_pool_id), its(:identity_pool_name)
## <a name="cognito_user_pool">cognito_user_pool</a>

CognitoUserPool resource type.

### exist

```ruby
describe cognito_user_pool('my-cognito-user-pool') do
  it { should exist }
end
```
### its(:id), its(:name), its(:status), its(:last_modified_date), its(:creation_date)
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


### its(:bgp_asn), its(:customer_gateway_id), its(:ip_address), its(:certificate_arn), its(:state), its(:type), its(:device_name), its(:tags)
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

### its(:owner_account), its(:virtual_interface_id), its(:location), its(:connection_id), its(:virtual_interface_type), its(:virtual_interface_name), its(:vlan), its(:asn), its(:amazon_side_asn), its(:auth_key), its(:amazon_address), its(:customer_address), its(:address_family), its(:virtual_interface_state), its(:customer_router_config), its(:mtu), its(:jumbo_frame_capable), its(:virtual_gateway_id), its(:direct_connect_gateway_id), its(:route_filter_prefixes), its(:bgp_peers), its(:region), its(:aws_device_v2), its(:tags)
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


### its(:table_name), its(:table_status), its(:creation_date_time), its(:table_size_bytes), its(:item_count), its(:table_arn), its(:table_id), its(:billing_mode_summary), its(:local_secondary_indexes), its(:global_secondary_indexes), its(:stream_specification), its(:latest_stream_label), its(:latest_stream_arn), its(:global_table_version), its(:replicas), its(:restore_summary), its(:sse_description), its(:archival_summary)
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


### its(:availability_zone), its(:create_time), its(:encrypted), its(:kms_key_id), its(:outpost_arn), its(:size), its(:snapshot_id), its(:state), its(:volume_id), its(:iops), its(:volume_type), its(:fast_restored), its(:multi_attach_enabled)
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


### have_credit_specification

The credit option for CPU usage of T2 or T3 instance.

```ruby
describe ec2('my-ec2') do
  it { should have_credit_specification('unlimited') }
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


### its(:ami_launch_index), its(:image_id), its(:instance_id), its(:instance_type), its(:kernel_id), its(:key_name), its(:launch_time), its(:monitoring), its(:placement), its(:platform), its(:private_dns_name), its(:private_ip_address), its(:product_codes), its(:public_dns_name), its(:public_ip_address), its(:ramdisk_id), its(:state_transition_reason), its(:subnet_id), its(:vpc_id), its(:architecture), its(:client_token), its(:ebs_optimized), its(:ena_support), its(:hypervisor), its(:instance_lifecycle), its(:elastic_gpu_associations), its(:elastic_inference_accelerator_associations), its(:outpost_arn), its(:root_device_name), its(:root_device_type), its(:source_dest_check), its(:spot_instance_request_id), its(:sriov_net_support), its(:state_reason), its(:virtualization_type), its(:cpu_options), its(:capacity_reservation_id), its(:capacity_reservation_specification), its(:hibernation_options), its(:licenses), its(:metadata_options)
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

#### Awspec::DuplicatedResourceTypeError exception

EC2 resources might have the same tag value and if you try to search for a
specific instance using that tag/tag value you might found multiples results
and receive a `Awspec::DuplicatedResourceTypeError` exception as result.

To avoid such situations, you will want to use EC2 instances ID's and then use
those ID's to test whatever you need.

There are several different ways to provide such ID's, like using [Terraform output](https://www.terraform.io/docs/configuration/outputs.html) or even the
AWS SDK directly:

```ruby
require 'awspec'
require 'aws-sdk-ec2'

tag_name = 'tag:Name'
tag_value = 'foobar'
servers = {}
ec2 = Aws::EC2::Resource.new
ec2.instances({filters: [{name: "#{tag_name}",
                          values: ["#{tag_value}"]}]}).each do |i|
  servers.store(i.id, i.subnet_id)
end

if servers.size == 0
  raise "Could not find any EC2 instance with #{tag_name} = #{tag_value}!"
end

servers.each_pair do |instance_id, subnet_id|
  describe ec2(instance_id) do
    it { should exist }
    it { should be_running }
    its(:image_id) { should eq 'ami-12345foobar' }
    its(:instance_type) { should eq 't2.micro' }
    it { should belong_to_subnet(subnet_id) }
  end
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

### its(:cluster_arn), its(:cluster_name), its(:status), its(:registered_container_instances_count), its(:running_tasks_count), its(:pending_tasks_count), its(:active_services_count), its(:statistics), its(:tags), its(:settings), its(:capacity_providers), its(:default_capacity_provider_strategy), its(:attachments), its(:attachments_status)
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


### its(:container_instance_arn), its(:ec2_instance_id), its(:capacity_provider_name), its(:version), its(:version_info), its(:status), its(:status_reason), its(:agent_connected), its(:running_tasks_count), its(:pending_tasks_count), its(:agent_update_status), its(:attributes), its(:registered_at), its(:attachments), its(:tags)
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

### its(:service_arn), its(:service_name), its(:cluster_arn), its(:load_balancers), its(:service_registries), its(:status), its(:desired_count), its(:running_count), its(:pending_count), its(:launch_type), its(:capacity_provider_strategy), its(:platform_version), its(:task_definition), its(:task_sets), its(:role_arn), its(:created_at), its(:placement_constraints), its(:placement_strategy), its(:network_configuration), its(:health_check_grace_period_seconds), its(:scheduling_strategy), its(:deployment_controller), its(:tags), its(:created_by), its(:enable_ecs_managed_tags), its(:propagate_tags)
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

### its(:task_definition_arn), its(:family), its(:task_role_arn), its(:execution_role_arn), its(:network_mode), its(:revision), its(:volumes), its(:status), its(:requires_attributes), its(:placement_constraints), its(:compatibilities), its(:requires_compatibilities), its(:cpu), its(:memory), its(:inference_accelerators), its(:pid_mode), its(:ipc_mode), its(:proxy_configuration)
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

### its(:owner_id), its(:creation_token), its(:file_system_id), its(:file_system_arn), its(:creation_time), its(:life_cycle_state), its(:name), its(:number_of_mount_targets), its(:performance_mode), its(:encrypted), its(:kms_key_id), its(:throughput_mode), its(:provisioned_throughput_in_mibps)
## <a name="elastic_ip">elastic_ip</a>

Elastic IP resource type.

### exist

```ruby
describe eip('123.0.456.789') do
  it { should exist }
end
```


### be_associated_to

```ruby
describe eip('123.0.456.789') do
  it { should be_associated_to('i-ec12345a') }
end
```


### belong_to_domain

```ruby
describe eip('123.0.456.789') do
  it { should belong_to_domain('vpc') }
end
```


## <a name="eks">eks</a>

Eks resource type.

### exist

```ruby
describe eks('my-eks') do
  it { should exist }
end
```

### be_active, be_creating

```ruby
describe eks('my-eks') do
  it { should be_active }
end
```

### its(:name), its(:arn), its(:created_at), its(:version), its(:endpoint), its(:role_arn), its(:logging), its(:identity), its(:status), its(:client_request_token), its(:platform_version), its(:tags), its(:encryption_config)
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

### its(:cache_cluster_id), its(:configuration_endpoint), its(:client_download_landing_page), its(:cache_node_type), its(:engine), its(:engine_version), its(:cache_cluster_status), its(:num_cache_nodes), its(:preferred_availability_zone), its(:cache_cluster_create_time), its(:preferred_maintenance_window), its(:notification_configuration), its(:cache_security_groups), its(:cache_subnet_group_name), its(:cache_nodes), its(:auto_minor_version_upgrade), its(:replication_group_id), its(:snapshot_retention_limit), its(:snapshot_window), its(:auth_token_enabled), its(:auth_token_last_modified_date), its(:transit_encryption_enabled), its(:at_rest_encryption_enabled), its(:arn)
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


### its(:domain_id), its(:domain_name), its(:arn), its(:created), its(:deleted), its(:endpoint), its(:endpoints), its(:processing), its(:upgrade_processing), its(:elasticsearch_version), its(:access_policies), its(:snapshot_options), its(:vpc_options), its(:cognito_options), its(:encryption_at_rest_options), its(:node_to_node_encryption_options), its(:advanced_options), its(:log_publishing_options), its(:service_software_options), its(:domain_endpoint_options), its(:advanced_security_options)
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


### be_cross_zone_load_balancing_enabled

```ruby
describe elb('my-elb') do
  it { should be_cross_zone_load_balancing_enabled }
end
```


### have_access_log

```ruby
describe elb('my-elb') do
  it { should have_access_log(s3_bucket_name: 'my-loadbalancer-logs', s3_bucket_prefix: 'my-app', emit_interval: 5) }
end
```


### have_connection_draining

```ruby
describe elb('my-elb') do
  it { should have_connection_draining(timeout: 300) }
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


### have_tag

```ruby
describe elb('my-elb') do
  it { should have_tag('Name').value('my-elb') }
  it { should have_tag('my-tag-key').value('my-tag-value') }
end
```


### belong_to_vpc

```ruby
describe elb('my-elb') do
  it { should belong_to_vpc('my-vpc') }
end
```


### its(:health_check_target), its(:health_check_interval), its(:health_check_timeout), its(:health_check_unhealthy_threshold), its(:health_check_healthy_threshold), its(:idle_timeout), its(:load_balancer_name), its(:dns_name), its(:canonical_hosted_zone_name), its(:canonical_hosted_zone_name_id), its(:backend_server_descriptions), its(:availability_zones), its(:subnets), its(:vpc_id), its(:security_groups), its(:created_time), its(:scheme)
## <a name="emr">emr</a>

Emr resource type.

### exist

```ruby
describe emr('my-emr') do
  it { should exist }
end
```

### be_healthy

```ruby
describe emr('my-emr') do
  it { should be_healthy }
end
```

### be_ok

### be_ready

### be_running, be_waiting, be_starting, be_bootstrapping

```ruby
describe emr('my-emr') do
  it { should be_running }
end
```

### its(:id), its(:name), its(:instance_collection_type), its(:log_uri), its(:log_encryption_kms_key_id), its(:requested_ami_version), its(:running_ami_version), its(:release_label), its(:auto_terminate), its(:termination_protected), its(:visible_to_all_users), its(:service_role), its(:normalized_instance_hours), its(:master_public_dns_name), its(:configurations), its(:security_configuration), its(:auto_scaling_role), its(:scale_down_behavior), its(:custom_ami_id), its(:ebs_root_volume_size), its(:repo_upgrade_on_boot), its(:cluster_arn), its(:outpost_arn), its(:step_concurrency_level)
## <a name="firehose">firehose</a>

Firehose resource type.

### exist

```ruby
describe firehose('my-firehose') do
  it { should exist }
end
```


### be_active

```ruby
describe firehose('my-firehose') do
  it { should be_active }
end
```


### be_creating

### be_deleting

### have_splunk_destination

```ruby
describe firehose('my-firehose') do
  it { should have_splunk_destination }
end
```


### its(:delivery_stream_name), its(:delivery_stream_arn), its(:delivery_stream_status), its(:failure_description), its(:delivery_stream_encryption_configuration), its(:delivery_stream_type), its(:version_id), its(:create_timestamp), its(:last_update_timestamp), its(:source), its(:has_more_destinations)
### :unlock: Advanced use

```ruby
describe firehose('my-firehose') do
  its(:delivery_stream_type) { should be_eql('DirectPut') }
end
```

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

```ruby
describe iam_group('my-iam-group') do
  it { should have_inline_policy('InlineEC2FullAccess') }
  it do
    should have_inline_policy('InlineEC2FullAccess').policy_document(<<-'DOC')
{
  "Statement": [
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:*",
      "Resource": "*"
    }
  ]
}
DOC
  end
end
```

You can test absence of inline policies.

```ruby
describe iam_group('my-iam-group') do
  it { should_not have_inline_policy }
end
```


### its(:path), its(:group_name), its(:group_id), its(:arn), its(:create_date)
### :unlock: Advanced use

`iam_group` can use `Aws::IAM::Group` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/IAM/Group.html).

```ruby
describe iam_group('my-iam-group') do
  its('users.count') { should eq 5 }
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

### its(:policy_name), its(:policy_id), its(:arn), its(:path), its(:default_version_id), its(:attachment_count), its(:permissions_boundary_usage_count), its(:is_attachable), its(:description), its(:create_date), its(:update_date)
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

You can test absence of inline policies.

```ruby
describe iam_role('my-iam-role') do
  it { should_not have_inline_policy }
end
```


### its(:path), its(:role_name), its(:role_id), its(:arn), its(:create_date), its(:assume_role_policy_document), its(:description), its(:max_session_duration), its(:permissions_boundary), its(:tags), its(:role_last_used)
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

You can test absence of inline policies.

```ruby
describe iam_user('my-iam-user') do
  it { should_not have_inline_policy }
end
```


### belong_to_iam_group

```ruby
describe iam_user('my-iam-user') do
  it { should belong_to_iam_group('my-iam-group') }
end
```


### its(:path), its(:user_name), its(:user_id), its(:arn), its(:create_date), its(:password_last_used), its(:permissions_boundary), its(:tags)
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

### its(:internet_gateway_id), its(:owner_id)
## <a name="kinesis">kinesis</a>

Kinesis resource type.

### exist

```ruby
describe kinesis('my-kinesis') do
  it { should exist }
end
```

### its(:stream_name), its(:stream_arn), its(:stream_status), its(:retention_period_hours), its(:stream_creation_timestamp), its(:encryption_type), its(:key_id), its(:open_shard_count), its(:consumer_count)
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

### its(:aws_account_id), its(:key_id), its(:arn), its(:creation_date), its(:enabled), its(:description), its(:key_usage), its(:key_state), its(:deletion_date), its(:valid_to), its(:origin), its(:custom_key_store_id), its(:cloud_hsm_cluster_id), its(:expiration_model), its(:key_manager), its(:customer_master_key_spec), its(:encryption_algorithms), its(:signing_algorithms)
## <a name="lambda">lambda</a>

Lambda resource type.

### exist

```ruby
describe lambda('my-lambda-function-name') do
  it { should exist }
end
```


### have_env_var

Useful to validate if there is a specific environment variable declared in the Lambda. You probably will want to use it with `have_env_var_value`.

## have_env_var_value

Validates if a specific environment variable has the expected value. More useful to use with `have_env_var` because if the variable isn't available, it will fail without notifying that the variable is missing.

```ruby
expected.each_pair do |key, value|
  context "environment variable #{key}" do
    it { should have_env_var(key) }
    it { should have_env_var_value(key, value) }
  end
end
```

`expected` would be a hash that has the environment variables names as keys.


### have_env_vars

Useful to validate if there are environment variables configured in the Lambda:

```ruby
describe lambda('my-lambda-function-name') do
  it { should have_env_vars() }
end
```


### have_event_source

This matcher does not support Amazon S3 event sources ([see SDK doc](http://docs.aws.amazon.com/sdkforruby/api/Aws/Lambda/Client.html#list_event_source_mappings-instance_method)).

### its(:function_name), its(:function_arn), its(:runtime), its(:role), its(:handler), its(:code_size), its(:description), its(:timeout), its(:memory_size), its(:last_modified), its(:code_sha_256), its(:version), its(:vpc_config), its(:dead_letter_config), its(:kms_key_arn), its(:master_arn), its(:revision_id), its(:layers), its(:state), its(:state_reason), its(:state_reason_code), its(:last_update_status), its(:last_update_status_reason), its(:last_update_status_reason_code), its(:file_system_configs)
## <a name="launch_configuration">launch_configuration</a>

LaunchConfiguration resource type.

### exist

```ruby
describe launch_configuration('my-lc') do
  it { should exist }
end
```


### have_block_device_mapping

### have_security_group

```ruby
describe launch_configuration('my-lc') do
  it { should have_security_group('my-security-group-name') }
end
```

### its(:launch_configuration_name), its(:launch_configuration_arn), its(:image_id), its(:key_name), its(:security_groups), its(:classic_link_vpc_id), its(:classic_link_vpc_security_groups), its(:user_data), its(:instance_type), its(:kernel_id), its(:ramdisk_id), its(:spot_price), its(:iam_instance_profile), its(:created_time), its(:ebs_optimized), its(:associate_public_ip_address), its(:placement_tenancy), its(:metadata_options)
## <a name="launch_template">launch_template</a>

LaunchTemplate resource type.

### exist

You can set launch template version ( default: $Default ).

```ruby
# launch_template_id or launch_template_name
describe launch_template('my-launch-template') do
  it { should exist }
  its(:default_version_number) { should eq 1 }
  its(:latest_version_number) { should eq 2 }
  its('launch_template_version.launch_template_data.image_id') { should eq 'ami-12345foobar' }
  its('launch_template_version.launch_template_data.instance_type') { should eq 't2.micro' }
end
```

#### specify version
 
Specify "latest" or version_number.
 
```ruby
# version_number
describe launch_template('my-launch-template'), version: 2 do
  it { should exist }
  its('launch_template_version.launch_template_data.instance_type') { should eq 't2.micro' }
end

# latest
describe launch_template('my-launch-template'), version: 'latest' do
  it { should exist }
  its('launch_template_version.launch_template_data.instance_type') { should eq 't2.micro' }
end
```
 

### have_tag

```ruby
describe launch_template('my-launch-template') do
  it { should have_tag('env').value('dev') }
end
```


### have_version_number

```ruby
describe launch_template('my-launch-template') do
  it { should have_version_number(2) }
end
```

### its(:launch_template_id), its(:launch_template_name), its(:create_time), its(:created_by), its(:default_version_number), its(:latest_version_number), its(:tags)
## <a name="mq">mq</a>

MQ resource type.

### exist

```ruby
describe mq('my-mq') do
  it { should exist }
end
```


### be_running, be_reboot_in_progress, be_creation_in_progress, be_creation_failed, be_deletion_in_progress

```ruby
describe mq('my-mq') do
  it { should be_running }
end
```


### have_security_group

```ruby
describe mq('my-mq') do
  it { should have_security_group('sg-788eab237e47f1472') }
  it { should have_security_group('mq-group-name-sg') }
  it { should have_security_group('my-mq-sg') }
end
```


### have_tag

```ruby
describe mq('my-mq') do
  it { should have_tag('Name').value('my-mq') }
end
```

### its(:vpc_id), its(:authentication_strategy), its(:auto_minor_version_upgrade), its(:broker_arn), its(:broker_id), its(:broker_name), its(:broker_state), its(:created), its(:deployment_mode), its(:encryption_options), its(:engine_type), its(:engine_version), its(:host_instance_type), its(:ldap_server_metadata), its(:pending_authentication_strategy), its(:pending_engine_version), its(:pending_host_instance_type), its(:pending_ldap_server_metadata), its(:pending_security_groups), its(:publicly_accessible), its(:security_groups), its(:storage_type), its(:subnet_ids)
## <a name="msk">msk</a>

Msk resource type.

### exist

```ruby
describe msk('my-msk') do
  it { should exist }
end
```


### be_active

### be_creating

### be_deleting

### be_failed

### be_updating

### its(:active_operation_arn), its(:client_authentication), its(:cluster_arn), its(:cluster_name), its(:creation_time), its(:current_version), its(:enhanced_monitoring), its(:number_of_broker_nodes), its(:state), its(:zookeeper_connect_string)
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


### have_tag

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should have_tag('Name').value('my-nat-gateway') }
end
```

### belong_to_vpc

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should belong_to_vpc('my-vpc') }
end
```


### its(:create_time), its(:delete_time), its(:failure_code), its(:failure_message), its(:nat_gateway_id), its(:provisioned_bandwidth), its(:state), its(:subnet_id), its(:vpc_id)
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


### its(:inbound_entries_count), its(:outbound_entries_count), its(:is_default), its(:network_acl_id), its(:vpc_id), its(:owner_id)
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

### its(:association), its(:availability_zone), its(:description), its(:interface_type), its(:ipv_6_addresses), its(:mac_address), its(:network_interface_id), its(:outpost_arn), its(:owner_id), its(:private_dns_name), its(:private_ip_address), its(:requester_id), its(:requester_managed), its(:source_dest_check), its(:status), its(:subnet_id), its(:vpc_id)
## <a name="nlb">nlb</a>

NLB resource type.

### exist

```ruby
describe nlb('my-nlb') do
  it { should exist }
end
```


### be_active, be_provisioning, be_failed

```ruby
describe nlb('my-nlb') do
  it { should be_active }
end
```


### have_security_group

Note that NLBs never have security groups. The have_security_group() function always returns false. See https://forums.aws.amazon.com/thread.jspa?threadID=263245 for discussion about the security-group-less-ness of NLBs.

```ruby
describe nlb('my-nlb') do
  it { should_not have_security_group('sg-1a2b3cd4') }
end
```


### have_subnet

```ruby
describe nlb('my-nlb') do
  it { should have_subnet('subnet-1234a567') }
end
```


### belong_to_vpc

```ruby
describe nlb('my-nlb') do
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:load_balancer_arn), its(:dns_name), its(:canonical_hosted_zone_id), its(:created_time), its(:load_balancer_name), its(:scheme), its(:vpc_id), its(:type), its(:security_groups), its(:ip_address_type)
## <a name="nlb_listener">nlb_listener</a>

NlbListener resource type.

### exist

```ruby
describe nlb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
end
```


### have_rule

```ruby
describe nlb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/9683b2d02a6cabee') }
  it do
    should have_rule.priority('10')
      .conditions(field: 'path-pattern', values: ['/img/*'])
      .actions(target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067', type: 'forward')
  end
  it do
    should have_rule.priority('10')
      .if(field: 'path-pattern', values: ['/img/*'])
      .then(target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067', type: 'forward')
  end
  it { should have_rule.conditions([{ field: 'path-pattern', values: ['/admin/*'] }, { field: 'host-header', values: ['admin.example.com'] }]) }
  it { should have_rule.actions(target_group_name: 'my-nlb-target-group', type: 'forward') }
end
```

### its(:listener_arn), its(:load_balancer_arn), its(:port), its(:protocol), its(:certificates), its(:ssl_policy), its(:alpn_policy)
## <a name="nlb_target_group">nlb_target_group</a>

NlbTargetGroup resource type.

### exist

```ruby
describe nlb_target_group('my-nlb-target-group') do
  it { should exist }
  its(:health_check_path) { should eq '/' }
  its(:health_check_port) { should eq 'traffic-port' }
  its(:health_check_protocol) { should eq 'HTTP' }
end
```


### have_ec2

```ruby
describe nlb_target_group('my-nlb-target-group') do
  it { should have_ec2('my-ec2') }
end
```


### belong_to_nlb

```ruby
describe nlb_target_group('my-nlb-target-group') do
  it { should belong_to_nlb('my-nlb') }
end
```


### belong_to_vpc

```ruby
describe nlb_target_group('my-nlb-target-group') do
  it { should belong_to_vpc('my-vpc') }
end
```


### its(:target_group_arn), its(:target_group_name), its(:protocol), its(:port), its(:vpc_id), its(:health_check_protocol), its(:health_check_port), its(:health_check_enabled), its(:health_check_interval_seconds), its(:health_check_timeout_seconds), its(:healthy_threshold_count), its(:unhealthy_threshold_count), its(:health_check_path), its(:load_balancer_arns), its(:target_type)
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
  it do
    should have_db_parameter_group('custom.mysql5.6')\
      .parameter_apply_status('in-sync')
  end
end
```


### have_option_group

```ruby
describe rds('my-rds') do
  it { should have_option_group('default:mysql-5-6') }
  it do
    should have_option_group('default:mysql-5-6')\
      .status('in-sync')
  end
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


### its(:vpc_id), its(:db_instance_identifier), its(:db_instance_class), its(:engine), its(:db_instance_status), its(:master_username), its(:db_name), its(:endpoint), its(:allocated_storage), its(:instance_create_time), its(:preferred_backup_window), its(:backup_retention_period), its(:db_security_groups), its(:availability_zone), its(:preferred_maintenance_window), its(:pending_modified_values), its(:latest_restorable_time), its(:multi_az), its(:engine_version), its(:auto_minor_version_upgrade), its(:read_replica_source_db_instance_identifier), its(:read_replica_db_instance_identifiers), its(:read_replica_db_cluster_identifiers), its(:replica_mode), its(:license_model), its(:iops), its(:character_set_name), its(:secondary_availability_zone), its(:publicly_accessible), its(:status_infos), its(:storage_type), its(:tde_credential_arn), its(:db_instance_port), its(:db_cluster_identifier), its(:storage_encrypted), its(:kms_key_id), its(:dbi_resource_id), its(:ca_certificate_identifier), its(:domain_memberships), its(:copy_tags_to_snapshot), its(:monitoring_interval), its(:enhanced_monitoring_resource_arn), its(:monitoring_role_arn), its(:promotion_tier), its(:db_instance_arn), its(:timezone), its(:iam_database_authentication_enabled), its(:performance_insights_enabled), its(:performance_insights_kms_key_id), its(:performance_insights_retention_period), its(:enabled_cloudwatch_logs_exports), its(:processor_features), its(:deletion_protection), its(:associated_roles), its(:listener_endpoint), its(:max_allocated_storage)
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


## <a name="redshift">redshift</a>

Redshift resource type.

### exist

```ruby
describe redshift('my-redshift') do
  it { should exist }
end
```


### be_available, be_cancelling_resize, be_creating, be_deleting, be_final_snapshot, be_hardware_failure, be_incompatible_hsm, be_incompatible_network, be_incompatible_parameters, be_incompatible_restore, be_modifying, be_rebooting, be_renaming, be_resizing, be_rotating_keys, be_storage_full, be_updating_hsm

```ruby
describe redshift('my-redshift') do
  it { should be_available }
end
```


### have_cluster_parameter_group

```ruby
describe redshift('my-redshift') do
  it { should have_cluster_parameter_group('my-pg') }
  it do
    should have_cluster_parameter_group('my-pg')\
      .parameter_apply_status('in-sync')
  end
end
```


### have_security_group

```ruby
describe redshift('my-redshift') do
  it { should have_security_group('sg-1a2b3c4d') }
  it { should have_security_group('group-name-sg') }
end
```


### have_tag

```ruby
describe redshift('my-redshift') do
  it { should have_tag('Name').value('my-cluster') }
end
```


### belong_to_cluster_subnet_group

```ruby
describe redshift('my-redshift') do
  it { should belong_to_cluster_subnet_group('my-sg') }
end
```


### belong_to_vpc

```ruby
describe redshift('my-redshift') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:vpc_id), its(:cluster_identifier), its(:node_type), its(:cluster_status), its(:cluster_availability_status), its(:modify_status), its(:master_username), its(:db_name), its(:endpoint), its(:cluster_create_time), its(:automated_snapshot_retention_period), its(:manual_snapshot_retention_period), its(:cluster_security_groups), its(:cluster_subnet_group_name), its(:vpc_id), its(:availability_zone), its(:preferred_maintenance_window), its(:pending_modified_values), its(:cluster_version), its(:allow_version_upgrade), its(:number_of_nodes), its(:publicly_accessible), its(:encrypted), its(:restore_status), its(:data_transfer_progress), its(:hsm_status), its(:cluster_snapshot_copy_status), its(:cluster_public_key), its(:cluster_nodes), its(:elastic_ip_status), its(:cluster_revision_number), its(:kms_key_id), its(:enhanced_vpc_routing), its(:iam_roles), its(:pending_actions), its(:maintenance_track_name), its(:elastic_resize_number_of_node_options), its(:deferred_maintenance_windows), its(:snapshot_schedule_identifier), its(:snapshot_schedule_state), its(:expected_next_snapshot_schedule_time), its(:expected_next_snapshot_schedule_time_status), its(:next_maintenance_window_start_time), its(:resize_info)
## <a name="redshift_cluster_parameter_group">redshift_cluster_parameter_group</a>

RedshiftClusterParameterGroup resource type.

```ruby
describe redshift_cluster_parameter_group('my-redshift-cluster-parameter-group') do
  its(:datestyle) { should eq 'ISO, MDY' }
  its(:query_group) { should eq 'default' }
  its(:require_ssl) { should eq 'false' }
end
```


### exist

```ruby
describe redshift_cluster_parameter_group('my-redshift-cluster-parameter-group') do
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
  it { should have_record_set('example.com.') }
  it { should have_record_set('example.com.').type('a') }
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

### its(:id), its(:name), its(:caller_reference), its(:config), its(:resource_record_set_count), its(:linked_service)
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


### its(:propagating_vgws), its(:route_table_id), its(:vpc_id), its(:owner_id)
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
      expiration: { days: 2 },
      transitions: [{ days: 3, storage_class: 'GLACIER' }],
      status: 'Enabled'
    )
  end

  it do
    should have_lifecycle_rule(
      id: 'MyRuleName2',
      prefix: '123/',
      noncurrent_version_expiration: { noncurrent_days: 2 },
      expiration: { days: 3 },
      transitions: [{ days: 5, storage_class: 'STANDARD_IA' }, { days: 10, storage_class: 'GLACIER' }],
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


### have_server_side_encryption

```
describe s3_bucket('my-bucket') do
  it { should have_server_side_encryption(algorithm: "AES256") }
  it { should have_server_side_encryption(algorithm: "aws:kms") }
end
```


### have_tag

```ruby
describe s3_bucket('my-bucket') do
  it { should have_tag('env').value('dev') }
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

## <a name="secretsmanager">secretsmanager</a>

Secretsmanager resource type.

### exist

```ruby
describe secretsmanager('my-secret') do
  it { should exist }
end
```


### have_tag

```ruby
describe secretsmanager('my-secret') do
  it { should have_tag('Name').value('my-secret') }
end
```

### its(:arn), its(:name), its(:description), its(:kms_key_id), its(:rotation_enabled), its(:rotation_lambda_arn), its(:last_rotated_date), its(:last_changed_date), its(:last_accessed_date), its(:deleted_date), its(:owning_service), its(:created_date)
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

### have_inbound_rule

### have_outbound_rule

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


### its(:inbound_rule_count), its(:outbound_rule_count), its(:inbound_permissions_count), its(:outbound_permissions_count), its(:description), its(:group_name), its(:owner_id), its(:group_id), its(:vpc_id)
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
## <a name="sns_topic">sns_topic</a>

SnsTopic resource type.

### exist

```ruby
describe sns_topic(topic_arn) do
  it { should exist }
end
```


### have_subscription

```ruby
describe sns_topic(topic_arn) do
  let(:subscription_arn) do
      subscription_arn: subscribed, # this is required
  end

  describe '#subscribed' do
    it do
      should have_subscription(subscribed)
    end
  end
end
```

An [automatic matcher](https://www.rubydoc.info/github/rspec/rspec-expectations/RSpec/Matchers) created due the predicate `has_subscription?` existing method of `Awspec::Type::SnsTopic` class.

It validates if a given AWS SNS ARN subscription exists in the SNS Topic.


### have_subscription_attributes

```ruby
describe sns_topic(topic_arn) do
  let(:expected_attribs) do
    { protocol: 'lambda',
      owner: '123456789',
      subscription_arn: subscribed, # this is required
      endpoint: 'arn:aws:lambda:us-east-1:123456789:function:foobar' }
  end

  describe '#subscribed' do
    it do
      should have_subscription_attributes(expected_attribs)
    end
  end
end
```

Where `:expected_attribs` is a hash with keys as properties that are part of a SNS Topic subscription:

* subscription_arn
* owner
* protocol
* endpoint
* topic_arn

You can use any combinations of key/values that will be used by `have_subscription_attributes`, but the `subscription_arn` is required and if it is missing, an exception will be generated.


### include_subscribed

```ruby
describe sns_topic(topic_arn) do
  it { should include_subscribed(subscribed) }
end
```


### its(:policy), its(:owner), its(:pending_subscriptions), its(:topic_arn), its(:effective_delivery_policy), its(:display_name), its(:confirmed_subscriptions), its(:deleted_subscriptions), its(:name)
### :unlock: Advanced use

You may want to validate the subscriptions too. For that, you probably will want to  use the methods `subscriptions` (that will return a list of the subscriptions ARN as symbols) and `has_subscription?` (that expects a SNS Topic subscription as parameter and will return `true` of `false` if it exists as a subscription) of the class `Awspec::Type::SnsTopic` to build the fixture in order to use the matcher `have_subscription_attributes`.

## <a name="sqs">sqs</a>

SQS resource type.

### exist

```ruby
describe sqs('my-queue') do
  it { should exist }
end
```

### have_tag

### its(:queue_arn), its(:approximate_number_of_messages), its(:approximate_number_of_messages_not_visible), its(:approximate_number_of_messages_delayed), its(:created_timestamp), its(:last_modified_timestamp), its(:visibility_timeout), its(:maximum_message_size), its(:message_retention_period), its(:delay_seconds), its(:receive_message_wait_time_seconds), its(:queue_url)
## <a name="ssm_parameter">ssm_parameter</a>

SsmParameter resource type.

### exist

```ruby
describe ssm_parameter('my-parameter') do
  it { should exist }
end
```


### be_encrypted

```ruby
describe ssm_parameter('my-parameter') do
  it { should be_encrypted }
end
```


### have_tag

```ruby
describe ssm_parameter('my-parameter') do
  it { should have_tag('my-key').value('my-value') }
end
```


### its(:name), its(:type), its(:key_id), its(:last_modified_date), its(:last_modified_user), its(:description), its(:allowed_pattern), its(:version), its(:tier), its(:policies), its(:data_type)
### :unlock: Advanced use

```ruby
describe ssm_parameter('my-parameter') do
  its(:key_id) { should be_eql('6a81f446-27b0-4d51-a04f-af7ddeea2e22') }
  its(:description) { should be_eql('Some string description') }
  its(:version) { should be_eql(1) }
end
```

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


### its(:availability_zone), its(:availability_zone_id), its(:available_ip_address_count), its(:cidr_block), its(:default_for_az), its(:map_public_ip_on_launch), its(:map_customer_owned_ip_on_launch), its(:customer_owned_ipv_4_pool), its(:state), its(:subnet_id), its(:vpc_id), its(:owner_id), its(:assign_ipv_6_address_on_creation), its(:ipv_6_cidr_block_association_set), its(:subnet_arn), its(:outpost_arn)
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

## <a name="transit_gateway">transit_gateway</a>

TransitGateway resource type.

### exist

```ruby
describe transit_gateway('tgw-1234567890abcdefg') do
  it { should exist }
  it { should have_tag('Name').value('my-tgw') }
  it { should have_attachment('tgw-attach-1234567890abcdefg') }
  its('options.amazon_side_asn') { should eq 64_516 }
  its('options.auto_accept_shared_attachments') { should eq 'enable' }
  its('options.default_route_table_association') { should eq 'enable' }
  its('options.default_route_table_propagation') { should eq 'enable' }
  its('options.dns_support') { should eq 'enable' }
  its('options.vpn_ecmp_support') { should eq 'enable' }
  its('options.association_default_route_table_id') { should eq 'tgw-rtb-0123456789abcdefg' }
  its('options.propagation_default_route_table_id') { should eq 'tgw-rtb-0123456789abcdefg' }
end
```

```ruby
describe transit_gateway('my-tgw') do
  it { should exist }
  its(:transit_gateway_id) { should eq 'tgw-1234567890abcdefg' }
end
```

### have_attachment

### have_tag

### its(:transit_gateway_id), its(:transit_gateway_arn), its(:state), its(:owner_id), its(:description), its(:creation_time)
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


### be_connected_to_vpc

```ruby
describe vpc('vpc-ab123cde') do
  it { should be_connected_to_vpc('vpc-bcd1235e') }
  it { should be_connected_to_vpc('vpc-bcd1235e').as_accepter }
  it { should_not be_connected_to_vpc('vpc-bcd1235e').as_requester }
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


### have_vpc_attribute

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_vpc_attribute('enableDnsHostnames') }
  it { should_not have_vpc_attribute('enableDnsSupport') }
end
```


### have_vpc_peering_connection

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_vpc_peering_connection('pcx-c56789de') }
  it { should have_vpc_peering_connection('pcx-c56789de').as_accepter }
  it { should_not have_vpc_peering_connection('pcx-c56789de').as_requester }
end
```


### its(:cidr_block), its(:dhcp_options_id), its(:state), its(:vpc_id), its(:owner_id), its(:instance_tenancy), its(:ipv_6_cidr_block_association_set), its(:cidr_block_association_set), its(:is_default)
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

## <a name="vpc_endpoints">vpc_endpoints</a>

VpcEndpoints resource type.

### exist

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should exist }
end
```

describe vpc_endpoints('vpce-05907f23265b25f20'), region: $tfvars["region"]["value"] do
  it { should exist }
  it { should be_available }
  it { should have_subnet('subnet-040e19eabf3226f99') }
  it { should belong_to_vpc('vpc-00af9dcc0134b48e0') }
  its(:private_dns_enabled) { should eq true }
  its(:vpc_endpoint_type) { should eq 'Interface' }
  its(:service_name) { should eq 'com.amazonaws.eu-west-1.codebuild' }
end


### be_available

### be_deleted

### be_deleting

### be_expired

### be_failed

### be_pending

### be_pendingacceptance

### be_rejected

### have_route_table

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should have_route_table('rtb-abc123') }
end
```


### have_subnet

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should have_subnet('subnet-abc123') }
end
```


### have_tag

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should have_tag('env').value('dev') }
end
```



### :unlock: Advanced use

`vpc_endpoints` can use `Aws::EC2::Types::VpcEndpoint` resource (see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/EC2/Types/VpcEndpoint.html).

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  its(:private_dns_enabled) { should eq true }
  its(:vpc_endpoint_type) { should eq 'Interface' }
  its(:service_name) { should eq 'com.amazonaws.eu-west-1.codebuild' }
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


### its(:customer_gateway_configuration), its(:customer_gateway_id), its(:category), its(:state), its(:type), its(:vpn_connection_id), its(:vpn_gateway_id), its(:transit_gateway_id), its(:options), its(:routes), its(:vgw_telemetry)
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


### its(:availability_zone), its(:state), its(:type), its(:vpc_attachments), its(:vpn_gateway_id), its(:amazon_side_asn), its(:tags)
## <a name="waf_web_acl">waf_web_acl</a>

WafWebAcl resource type.

### exist

```ruby
describe waf_web_acl('my-waf-web-acl') do
  it { should exist }
  its(:default_action) { should eq 'BLOCK' }
  it { should have_rule('my-waf-web-acl-allowed-ips') }
  it { should have_rule('my-waf-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```


### have_rule

```ruby
describe waf_web_acl('my-waf-web-acl') do
  it { should have_rule('my-waf-web-acl-allowed-ips') }
  it { should have_rule('my-waf-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```


### its(:default_action), its(:web_acl_id), its(:name), its(:metric_name), its(:web_acl_arn)
## <a name="wafregional_web_acl">wafregional_web_acl</a>

WafregionalWebAcl resource type.

### exist

```ruby
describe wafregional_web_acl('my-wafregional-web-acl') do
  it { should exist }
  its(:default_action) { should eq 'BLOCK' }
  it { should have_rule('my-wafregional-web-acl-allowed-ips') }
  it { should have_rule('my-wafregional-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```


### have_rule

```ruby
describe wafregional_web_acl('my-wafregional-web-acl') do
  it { should have_rule('my-wafregional-web-acl-allowed-ips') }
  it { should have_rule('my-wafregional-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```


### its(:default_action), its(:web_acl_id), its(:name), its(:metric_name), its(:web_acl_arn)
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
  its('lambda.unreserved_concurrent_executions.limit') { should eq 50 }
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
  its('unreserved_concurrent_executions.limit') { should eq 50 }
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
