require 'spec_helper'
Awspec::Stub.load 'elasticache_cache_parameter_group'

describe elasticache_cache_parameter_group('my-redis-parameter-group') do
  it { should exist }
  its(:activerehashing) { should eq 'yes' }
  its(:client_output_buffer_limit_pubsub_hard_limit) { should eq '33554432' }
end
