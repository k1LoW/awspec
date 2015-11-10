require 'spec_helper'
Awspec::Stub.load 'network_acl'

describe network_acl('my-network-acl') do
  it { should exist }
end
