#!/usr/bin/env ruby

require 'awspec'

Aws.config[:stub_responses] = true

types = %w(
  ec2 rds rds_db_parameter_group security_group
  vpc s3 route53_hosted_zone auto_scaling_group subnet
  route_table ebs
)
links = types.map do |type|
  '[' + type + '](#' + type + ')'
end
header = <<-'EOF'
## Resource Types

<%= links.join('|') %>

EOF
puts ERB.new(header, nil, '-').result(binding)

types.map do |type|
  puts eval "Awspec::Generator::Doc::#{type.to_camel_case}.new.generate_doc"
end
