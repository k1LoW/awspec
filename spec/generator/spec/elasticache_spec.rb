# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Elasticache' do
  before do
    Awspec::Stub.load 'elasticache'
  end
  let(:elasticache) { Awspec::Generator::Spec::Elasticache.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe elasticache('my-rep-group-001') do
  it { should exist }
  it { should be_available }
  it { should have_cache_parameter_group('my-cache-parameter-group') }
  it { should belong_to_cache_subnet_group('my-cache-subnet-group') }
  its(:replication_group_id) { should eq 'my-rep-group' }
  its(:cache_type) { should eq 'cache_cluster' }
  its(:engine) { should eq 'redis' }
  its(:engine_version) { should eq '2.8.21' }
  its(:cache_node_type) { should eq 'cache.m3.medium' }
  its(:num_nodes) { should eq 1 }
  its(:snapshot_retention_limit) { should eq 0 }
  its(:snapshot_window) { should eq '17:30-18:30' }
end
describe elasticache('my-rep-group') do
  it { should exist }
  it { should be_available }
  it { should have_cache_parameter_group('my-cache-parameter-group') }
  it { should belong_to_cache_subnet_group('my-cache-subnet-group') }
  its(:cache_type) { should eq 'replication_group' }
  its(:engine) { should eq 'redis' }
  its(:engine_version) { should eq '7.1' }
  its(:cluster_mode_enabled) { should eq true }
  its(:num_nodes) { should eq 2 }
end
describe elasticache('my-serverless-cache') do
  it { should exist }
  it { should be_available }
  its(:cache_type) { should eq 'serverless_cache' }
  its(:serverless) { should eq true }
  its(:engine) { should eq 'valkey' }
  its(:engine_version) { should eq '7.2' }
end
EOF
    expect(elasticache.generate_all.to_s).to eq spec
  end
end
