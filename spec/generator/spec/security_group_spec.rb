# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::SecurityGroup' do
  before do
    Awspec::Stub.load 'security_group'
  end
  let(:security_group) { Awspec::Generator::Spec::SecurityGroup.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe security_group('my-security-group-name') do
  it { should exist }
  its(:group_id) { should eq 'sg-1a2b3cd4' }
  its(:group_name) { should eq 'my-security-group-name' }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.45.67.0/24') }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.45.68.89/32') }
  its(:inbound) { should be_opened(22).protocol('tcp').for('group-name-sg') }
  its(:inbound) { should be_opened(60000).protocol('tcp').for('100.45.67.12/32') }
  its(:inbound) { should be_opened(70000).protocol('tcp').for('100.45.67.89/32') }
  its(:inbound) { should be_opened(70000).protocol('tcp').for('100.45.67.12/32') }
  its(:inbound) { should be_opened('50000-50009').protocol('tcp').for('123.45.67.89/32') }
  its(:inbound) { should be_opened.protocol('all').for('sg-3a4b5cd6') }
  its(:outbound) { should be_opened(50000).protocol('tcp').for('100.45.67.12/32') }
  its(:outbound) { should be_opened(443).protocol('tcp').for('0.0.0.0/0') }
  its(:outbound) { should be_opened(8080).protocol('tcp').for('group-in-other-aws-account-with-vpc-peering') }
  its(:inbound_rule_count) { should eq 8 }
  its(:outbound_rule_count) { should eq 3 }
  its(:inbound_permissions_count) { should eq 7 }
  its(:outbound_permissions_count) { should eq 4 }
  it { should belong_to_vpc('my-vpc') }
end
EOF
    expect(security_group.generate_by_vpc_id('my-security-group-name').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
