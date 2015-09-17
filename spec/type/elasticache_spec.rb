require 'spec_helper'
Awspec::Stub.load 'elasticache'

describe elasticache('my-rep-group-001') do
  it { should exist }
  it { should be_available }
end
