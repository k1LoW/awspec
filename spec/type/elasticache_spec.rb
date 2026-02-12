# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'elasticache'

describe elasticache('my-rep-group-001') do
  it { should exist }
  it { should be_available }
  it { should have_cache_parameter_group('my-cache-parameter-group') }
  it { should belong_to_replication_group('my-rep-group') }
  it { should belong_to_cache_subnet_group('my-cache-subnet-group') }
  it { should belong_to_vpc('my-vpc') }
  it { should have_security_group('sg-da1bc2ef') }
  it { should have_security_group('group-name-sg') }
  it { should have_security_group('my-cache-sg') }
  its(:cache_type) { should eq 'cache_cluster' }
  its(:engine) { should eq 'redis' }
  its(:engine_version) { should eq '2.8.21' }
  its(:num_nodes) { should eq 1 }
  its(:cluster_mode_enabled) { should eq false }
  its(:serverless) { should eq false }
end

describe elasticache('my-rep-group') do
  it { should exist }
  it { should be_available }
  it { should have_cache_parameter_group('my-cache-parameter-group') }
  it { should belong_to_cache_subnet_group('my-cache-subnet-group') }
  its(:cache_type) { should eq 'replication_group' }
  its(:engine) { should eq 'redis' }
  its(:engine_version) { should eq '7.1' }
  its(:num_nodes) { should eq 2 }
  its(:cluster_mode_enabled) { should eq true }
  its(:serverless) { should eq false }
end

describe elasticache('my-serverless-cache') do
  it { should exist }
  it { should be_available }
  its(:cache_type) { should eq 'serverless_cache' }
  its(:engine) { should eq 'valkey' }
  its(:engine_version) { should eq '7.2' }
  its(:serverless) { should eq true }
end
