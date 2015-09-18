require 'spec_helper'
Awspec::Stub.load 'elasticache_cache_parameter_group'

describe elasticache_cache_parameter_group('my-elasticache-cache-parameter-group') do
  it { should exist }
end
