# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awspec/version'

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = 'awspec'
  spec.version       = Awspec::VERSION
  spec.authors       = ['k1LoW']
  spec.email         = ['k1lowxb@gmail.com']

  spec.summary       = 'RSpec tests for your AWS resources.'
  spec.description   = 'RSpec tests for your AWS resources.'
  spec.homepage      = 'https://github.com/k1LoW/awspec'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'
  spec.add_runtime_dependency 'aws-sdk-acm'
  spec.add_runtime_dependency 'aws-sdk-apigateway'
  spec.add_runtime_dependency 'aws-sdk-autoscaling'
  spec.add_runtime_dependency 'aws-sdk-batch'
  spec.add_runtime_dependency 'aws-sdk-cloudformation'
  spec.add_runtime_dependency 'aws-sdk-cloudfront'
  spec.add_runtime_dependency 'aws-sdk-cloudtrail'
  spec.add_runtime_dependency 'aws-sdk-cloudwatch'
  spec.add_runtime_dependency 'aws-sdk-cloudwatchevents'
  spec.add_runtime_dependency 'aws-sdk-cloudwatchlogs'
  spec.add_runtime_dependency 'aws-sdk-codebuild'
  spec.add_runtime_dependency 'aws-sdk-codedeploy'
  spec.add_runtime_dependency 'aws-sdk-core', '~> 3'
  spec.add_runtime_dependency 'aws-sdk-directconnect'
  spec.add_runtime_dependency 'aws-sdk-dynamodb'
  spec.add_runtime_dependency 'aws-sdk-ecr'
  spec.add_runtime_dependency 'aws-sdk-ecs'
  spec.add_runtime_dependency 'aws-sdk-efs'
  spec.add_runtime_dependency 'aws-sdk-eks'
  spec.add_runtime_dependency 'aws-sdk-elasticache'
  spec.add_runtime_dependency 'aws-sdk-elasticloadbalancing'
  spec.add_runtime_dependency 'aws-sdk-elasticsearchservice'
  spec.add_runtime_dependency 'aws-sdk-elastictranscoder'
  spec.add_runtime_dependency 'aws-sdk-emr'
  spec.add_runtime_dependency 'aws-sdk-firehose'
  spec.add_runtime_dependency 'aws-sdk-iam'
  spec.add_runtime_dependency 'aws-sdk-kinesis'
  spec.add_runtime_dependency 'aws-sdk-kms'
  spec.add_runtime_dependency 'aws-sdk-lambda'
  spec.add_runtime_dependency 'aws-sdk-mq'
  spec.add_runtime_dependency 'aws-sdk-rds'
  spec.add_runtime_dependency 'aws-sdk-redshift'
  spec.add_runtime_dependency 'aws-sdk-secretsmanager'
  spec.add_runtime_dependency 'aws-sdk-ses'
  spec.add_runtime_dependency 'aws-sdk-sns'
  spec.add_runtime_dependency 'aws-sdk-sqs'
  spec.add_runtime_dependency 'aws-sdk-ssm'
  spec.add_runtime_dependency 'aws-sdk-waf'
  spec.add_runtime_dependency 'aws-sdk-wafregional'
  spec.add_runtime_dependency 'awsecrets', '~> 1'
  spec.add_runtime_dependency 'dry-inflector'
  spec.add_runtime_dependency 'ipaddress'
  spec.add_runtime_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'rspec-its'
  spec.add_runtime_dependency 'term-ansicolor'
  spec.add_runtime_dependency 'thor'
  spec.add_development_dependency 'bundler', '>= 1.9', '< 2.1'
  spec.add_development_dependency 'octorelease'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'
end
