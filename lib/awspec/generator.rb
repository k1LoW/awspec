# Spec
require 'awspec/generator/spec/ec2'
require 'awspec/generator/spec/rds'
require 'awspec/generator/spec/vpc'
require 'awspec/generator/spec/security_group'
require 'awspec/generator/spec/route53_hosted_zone'
require 'awspec/generator/spec/efs'
require 'awspec/generator/spec/elb'
require 'awspec/generator/spec/iam_policy'
require 'awspec/generator/spec/kms'
require 'awspec/generator/spec/cloudwatch_alarm'
require 'awspec/generator/spec/cloudwatch_event'
require 'awspec/generator/spec/network_acl'
require 'awspec/generator/spec/route_table'
require 'awspec/generator/spec/subnet'
require 'awspec/generator/spec/directconnect'
require 'awspec/generator/spec/ebs'
require 'awspec/generator/spec/s3_bucket'
require 'awspec/generator/spec/nat_gateway'
require 'awspec/generator/spec/lambda'
require 'awspec/generator/spec/network_interface'
require 'awspec/generator/spec/iam_user'
require 'awspec/generator/spec/iam_group'
require 'awspec/generator/spec/iam_role'
require 'awspec/generator/spec/acm'
require 'awspec/generator/spec/cloudwatch_logs'
require 'awspec/generator/spec/alb'
require 'awspec/generator/spec/nlb'
require 'awspec/generator/spec/internet_gateway'
require 'awspec/generator/spec/elasticsearch'
require 'awspec/generator/spec/eip'
require 'awspec/generator/spec/rds_db_parameter_group'
require 'awspec/generator/spec/rds_db_cluster_parameter_group'
require 'awspec/generator/spec/codebuild'
require 'awspec/generator/spec/autoscaling_group'
require 'awspec/generator/spec/alb_listener'
require 'awspec/generator/spec/nlb_listener'
require 'awspec/generator/spec/redshift'
require 'awspec/generator/spec/redshift_cluster_parameter_group'

# Doc
require 'awspec/generator/doc/type'
require 'awspec/generator/doc/type/base'
require 'awspec/generator/doc/type/account_attribute_base'
Awspec::Helper::Type::TYPES.each do |type|
  require 'awspec/generator/doc/type/' + type
end
Awspec::Helper::Type::ACCOUNT_ATTRIBUTES.each do |type|
  require 'awspec/generator/doc/type/' + type
end
require 'awspec/generator/doc/type/account'
require 'awspec/generator/doc/type/account_attribute'

# Template
require 'awspec/generator/template'
