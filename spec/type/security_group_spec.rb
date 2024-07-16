# frozen_string_literal: true

require 'spec_helper'
require 'awspec/error'

Awspec::Stub.load 'security_group'

describe security_group('sg-1a2b3cd4') do
  it { should exist }
  it do
    # only way found to force and test the exception
    subject.inbound
    expect { subject.opened?(nil) }.to raise_error(Awspec::MissingPortSpecification, /protocol\sis\s-1$/)
  end
  its(:inbound) { should_not be_opened(80) }
  its(:inbound) { should_not be_opened(80).protocol(-1) }
  its(:inbound) { should be_opened(80).protocol(-1).for('sg-3a4b5cd6') }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.45.68.89/32') }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.45.67.0/25') }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.45.67.1/32') }
  its(:inbound) { should_not be_opened(80).protocol('tcp').for('123.45.0.0/16') }

  its(:inbound) { should be_opened(22).protocol('tcp').for('sg-1a2b3cd4') }
  its(:inbound) { should be_opened(22).protocol('udp').for('sg-1a2b3cd4') }
  its(:inbound) { should be_opened(22).protocol('-1').for('sg-1a2b3cd4') }
  its(:inbound) { should be_opened(22).protocol('icmp').for('sg-1a2b3cd4') }

  its(:inbound) { should be_opened(22).protocol('tcp').for('sg-5a6b7cd8') }
  its(:inbound) { should be_opened('50000-50009').protocol('tcp').for('123.45.67.89/32') }
  its(:inbound) { should_not be_opened('50010-50019').protocol('tcp').for('123.45.67.89/32') }

  its(:outbound) { should be_opened(50_000).protocol('tcp').for('sg-1a2b3cd4') }
  its(:outbound) { should be_opened(50_000).protocol('udp').for('sg-1a2b3cd4') }
  its(:outbound) { should be_opened(50_000).protocol('icmp').for('sg-1a2b3cd4') }
  its(:outbound) { should be_opened(50_000).protocol('-1').for('sg-1a2b3cd4') }

  its(:outbound) { should be_opened(8080).protocol('tcp').for('sg-9a8b7c6d') }
  its(:outbound) { should be_opened(8080).protocol('tcp').for('group-in-other-aws-account-with-vpc-peering') }
  its(:inbound) { should be_opened_only(60_000).protocol('tcp').for('100.45.67.12/32') }
  its(:inbound) { should be_opened_only(70_000).protocol('tcp').for(['100.45.67.89/32', '100.45.67.12/32']) }
  its(:outbound) { should be_opened_only(50_000).protocol('tcp').for('100.45.67.12/32') }
  its(:inbound) { should be_opened.protocol('-1').for('sg-3a4b5cd6') }

  it do
    # only way found to force and test the exception
    subject.outbound
    expect { subject.opened?(nil, 'tcp', 'pl-a5321fa3') }.to raise_error(
      Awspec::MissingPortSpecification, /protocol\sis\s-1$/)
  end
  its(:outbound) { should be_opened('443').protocol('tcp').for('pl-a5321fa3') }
  its(:outbound) { should be_opened(443).protocol('tcp').for('pl-a5321fa3') }
  its(:outbound) { should be_opened('443-443').protocol('tcp').for('pl-a5321fa3') }
  it do
    # only way found to force and test the exception
    subject.outbound
    expect { subject.opened?('yada-443-yada', 'tcp', 'pl-a5321fa3') }.to raise_error(Awspec::InvalidPortRange)
  end

  its(:inbound_permissions_count) { should eq 7 }
  its(:ip_permissions_count) { should eq 7 }
  its(:outbound_permissions_count) { should eq 4 }
  its(:ip_permissions_egress_count) { should eq 4 }
  its(:inbound_rule_count) { should eq 8 }
  its(:outbound_rule_count) { should eq 3 }

  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should have_tag('env').value('dev') }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('resource.group_name') { should eq 'my-security-group-name' }
  end
end

describe security_group('sg-1a2b3cd4') do
  it {
    should have_inbound_rule({ ip_protocol: 'tcp', from_port: 80, to_port: 80, ip_range: '123.45.67.0/24' })
  }
  it {
    should have_inbound_rule({ ip_protocol: 'tcp', from_port: 80, to_port: 80, ip_range: '123.45.68.89/32' })
  }
  it {
    should have_inbound_rule({
                               ip_protocol: 'tcp', from_port: 22, to_port: 22, group_pair: {
                                 group_id: 'sg-5a6b7cd8'
                               }
                             })
  }
  it {
    should have_inbound_rule({
                               ip_protocol: 'tcp', from_port: 22, to_port: 22, group_pair: {
                                 group_name: 'group-name-sg'
                               }
                             })
  }
  it {
    should have_inbound_rule({ ip_protocol: 'tcp', from_port: 60_000, to_port: 60_000, ip_range: '100.45.67.12/32' })
  }
  it {
    should have_inbound_rule({ ip_protocol: 'tcp', from_port: 70_000, to_port: 70_000, ip_range: '100.45.67.89/32' })
  }
  it {
    should have_inbound_rule({ ip_protocol: 'tcp', from_port: 70_000, to_port: 70_000, ip_range: '100.45.67.12/32' })
  }
  it {
    should have_inbound_rule({ ip_protocol: 'tcp', from_port: 50_000, to_port: 50_009, ip_range: '123.45.67.89/32' })
  }
  it {
    should have_inbound_rule({ ip_protocol: 'all', group_pair: { group_id: 'sg-3a4b5cd6', user_id: '1234567890' } })
  }
  it {
    should have_outbound_rule({ ip_protocol: 'tcp', from_port: 50_000, to_port: 50_000, ip_range: '100.45.67.12/32' })
  }
  it {
    should have_outbound_rule({
                                ip_protocol: 'tcp',
                                from_port: 8080,
                                to_port: 8080,
                                group_pair: {
                                  group_id: 'sg-9a8b7c6d',
                                  user_id: '5678901234',
                                  vpc_id: 'vpc-5b6a7c8f',
                                  vpc_peering_connection_id: 'pcx-f9e8d7c6',
                                  peering_status: 'active'
                                }
                              })
  }
  it { should have_outbound_rule({ ip_protocol: 'tcp', from_port: 443, to_port: 443, prefix_list_id: 'pl-a5321fa3' }) }
end

describe security_group('my-security-group-name') do
  it { should exist }
  its(:outbound) { should_not be_opened(50_000) }
  its(:outbound) { should_not be_opened(50_000).protocol('tcp') }
  its(:outbound) { should be_opened(50_000).protocol('tcp').target('100.45.67.12/32') }
  its(:outbound) { should be_opened(443).protocol('tcp').target('0.0.0.0/0') }
  its(:outbound) { should be_opened(443).protocol('tcp') }
  its(:inbound) { should_not be_opened(80) }
  its(:inbound) { should_not be_opened(80).protocol('tcp') }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.45.67.0/24') }
  its(:inbound) { should be_opened(80).protocol('tcp').for('123.45.68.89/32') }
  it { should belong_to_vpc('my-vpc') }
  it { should have_tag('env').value('dev') }
end
