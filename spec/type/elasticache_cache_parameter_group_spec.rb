require 'spec_helper'
Awspec::Stub.load 'elasticache_cache_parameter_group'

describe elasticache_cache_parameter_group('my-cache-parameter-group') do
  it { should exist }
  its(:activerehashing) { should eq 'yes' }
  its(:client_output_buffer_limit_pubsub_hard_limit) { should eq '33554432' }
  its(:repl_timeout) { should eq '60' }
  its(:timeout) { should eq '0' }
  its(:tcp_keepalive) { should eq '300' }
  its('repl-timeout') { should eq '60' }
  its('timeout') { should eq '0' }
  its('tcp-keepalive') { should eq '300' }
end
