require 'spec_helper'
Awspec::Stub.load 'elasticache'

describe elasticache('my-rep-group-001') do
  it { should exist }
  it { should be_available }
  it { should have_cache_parameter_group('my-cache-parameter-group') }
  it { should belong_to_replication_group('my-rep-group') }
end
