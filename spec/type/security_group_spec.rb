require 'spec_helper'
Awspec::Stub.load 'security_group'

describe security_group('sg-1a2b3cd4') do
  it { should exist }
  its(:inbound) { should be_opened(80) }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.456.789.012/32') }
  its(:inbound) { should be_opened(80).protocol('tcp').for('456.789.123.456/32') }
  its(:inbound) { should be_opened(22) }
  its(:inbound) { should be_opened(22).protocol('tcp').for('sg-5a6b7cd8') }
  its(:inbound) { should be_opened('50000-50009').protocol('tcp').for('123.456.789.012/32') }
  its(:inbound) { should_not be_opened('50010-50019').protocol('tcp').for('123.456.789.012/32') }
  its(:outbound) { should be_opened(50_000) }
  its(:inbound) { should be_opened_only(60_000).protocol('tcp').for('100.456.789.012/32') }
  its(:inbound) { should be_opened_only(70_000).protocol('tcp').for(['100.456.789.012/32', '101.456.789.012/32']) }
  its(:outbound) { should be_opened_only(50_000).protocol('tcp').for('100.456.789.012/32') }
  its(:inbound_permissions_count) { should eq 6 }
  its(:ip_permissions_count) { should eq 6 }
  its(:outbound_permissions_count) { should eq 1 }
  its(:ip_permissions_egress_count) { should eq 1 }
  its(:inbound_rule_count) { should eq 7 }
  its(:outbound_rule_count) { should eq 1 }
  # its(:inbound) { should be_opened(22).protocol('tcp').for('group-name-sg') }
  # its(:inbound) { should be_opened(22).protocol('tcp').for('my-db-sg') }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('resource.group_name') { should eq 'my-security-group-name' }
  end
end

describe security_group('my-security-group-name') do
  it { should exist }
  its(:outbound) { should be_opened(50_000) }
  its(:inbound) { should be_opened(80) }
  it { should belong_to_vpc('my-vpc') }
end

describe security_group('my-security-tag-name') do
  its(:outbound) { should be_opened(50_000) }
  its(:inbound) { should be_opened(80) }
  it { should belong_to_vpc('my-vpc') }
end
