require 'spec_helper'
Awspec::Stub.load 'elasticache'

describe elasticache('my-elasticache') do
  it { should exist }
end
