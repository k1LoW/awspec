# Spec
require 'awspec/generator/spec/ec2'
require 'awspec/generator/spec/rds'
require 'awspec/generator/spec/vpc'
require 'awspec/generator/spec/security_group'
require 'awspec/generator/spec/route53_hosted_zone'
require 'awspec/generator/spec/elb'
require 'awspec/generator/spec/iam_policy'
require 'awspec/generator/spec/cloudwatch_alarm'
require 'awspec/generator/spec/network_acl'
require 'awspec/generator/spec/route_table'
require 'awspec/generator/spec/subnet'
require 'awspec/generator/spec/directconnect'
require 'awspec/generator/spec/ebs'
require 'awspec/generator/spec/s3_bucket'
require 'awspec/generator/spec/nat_gateway'
require 'awspec/generator/spec/lambda'
require 'awspec/generator/spec/network_interface'

# Doc
require 'awspec/generator/doc/type'
require 'awspec/generator/doc/type/base'
Awspec::Helper::Type::TYPES.each do |type|
  require 'awspec/generator/doc/type/' + type
end

# Template
require 'awspec/generator/template'
