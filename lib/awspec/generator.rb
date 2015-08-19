types = Awspec::Helper::Type::TYPES

# Spec
require 'awspec/generator/spec/ec2'
require 'awspec/generator/spec/rds'
require 'awspec/generator/spec/vpc'
require 'awspec/generator/spec/security_group'
require 'awspec/generator/spec/route53_hosted_zone'

# Doc
types.each do |type|
  require 'awspec/generator/doc/' + type
end
