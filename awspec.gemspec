# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awspec/version'

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
  spec.add_runtime_dependency 'aws-sdk', '~> 3'
  spec.add_runtime_dependency 'awsecrets', '~> 1'
  spec.add_runtime_dependency 'dry-inflector'
  spec.add_runtime_dependency 'ipaddress'
  spec.add_runtime_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'rspec-its'
  spec.add_runtime_dependency 'term-ansicolor'
  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'addressable'
  spec.add_development_dependency 'bundler', '>= 1.9', '< 3.0'
  spec.add_development_dependency 'octorelease'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'
end
