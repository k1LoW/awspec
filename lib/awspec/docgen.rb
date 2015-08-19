#!/usr/bin/env ruby

require 'awspec'

Aws.config[:stub_responses] = true

header = <<-'EOF'
## Resource Types

[ec2](#ec2)
|[rds](#rds)

EOF
puts header
generator = Awspec::Generator::Doc::Ec2.new
puts generator.generate_doc

generator = Awspec::Generator::Doc::Rds.new
puts generator.generate_doc
