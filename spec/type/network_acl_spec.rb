require 'spec_helper'
Awspec::Stub.load 'network_acl'

describe network_acl('my-network-acl') do
  it { should exist }
  it { should belong_to_vpc('my-vpc') }
  it { should have_subnet('my-subnet') }
  its(:inbound) { should be_allowed(80).protocol('tcp').source('123.0.456.789/32') }
  its(:inbound) { should be_denied.rule_number('*').source('0.0.0.0/0') }
  its(:outbound) { should be_allowed.protocol('ALL').source('0.0.0.0/0') }
  its(:inbound_entries_count) { should eq 3 }
  its(:outbound_entries_count) { should eq 2 }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('resource.vpc.id') { should eq 'vpc-ab123cde' }
    its('vpc.id') { should eq 'vpc-ab123cde' }
  end
  it { should have_tag('Name').value('my-network-acl') }
end

describe network_acl(name: 'my-network-acl', vpc_id: 'my-vpc') do
  it { should exist }
  it { should belong_to_vpc('my-vpc') }
end
