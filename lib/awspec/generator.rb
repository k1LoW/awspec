# Spec
require 'awspec/generator/spec/ec2'
require 'awspec/generator/spec/rds'
require 'awspec/generator/spec/vpc'
require 'awspec/generator/spec/security_group'
require 'awspec/generator/spec/route53_hosted_zone'

# Doc
require 'awspec/generator/doc/base'
types = %w(
  base ec2 rds rds_db_parameter_group security_group
  vpc s3 route53_hosted_zone auto_scaling_group subnet
  route_table ebs
)
types.each do |type|
  require 'awspec/generator/doc/' + type
end
