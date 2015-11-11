require 'spec_helper'
Awspec::Stub.load 'network_acl'

describe network_acl('my-network-acl') do
  it { should exist }
  it { should belong_to_vpc('my-vpc') }
  it { should have_subnet('my-subnet') }
  its(:inbound) { should be_allowed(80).protocol('tcp').source('123.0.456.789/32') }
  its(:inbound) { should be_denied.rule_number('*').source('0.0.0.0/0') }
  its(:outbound) { should be_allowed.protocol('ALL').source('0.0.0.0/0') }
end
