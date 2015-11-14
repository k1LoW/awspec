types = Awspec::Helper::Type::TYPES

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

# Doc
require 'awspec/generator/doc/type'
types.each do |type|
  require 'awspec/generator/doc/type/' + type
end

# Template
require 'awspec/generator/template'
