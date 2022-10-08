# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'vpc'

describe vpc('vpc-ab123cde') do
  it { should exist }
  it { should be_available }
  it { should have_route_table('rtb-a12bcd34') }
  it { should have_route_table('my-route-table') }
  it { should have_network_acl('acl-1abc2d3e') }
  it { should have_network_acl('my-network-acl') }
  it { should be_connected_to_vpc('vpc-bcd1235e') }
  it { should be_connected_to_vpc('vpc-bcd1235e').as_accepter }
  it { should_not be_connected_to_vpc('vpc-bcd1235e').as_requester }
  it { should have_vpc_peering_connection('pcx-c56789de') }
  it { should have_vpc_peering_connection('pcx-c56789de').as_accepter }
  it { should_not have_vpc_peering_connection('pcx-c56789de').as_requester }
  it { should have_vpc_attribute('enableDnsHostnames') }
  it { should_not have_vpc_attribute('enableDnsSupport') }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('route_tables.first.route_table_id') { should eq 'rtb-a12bcd34' }
  end

  it { should have_tag('Name').value('my-vpc') }
end

describe vpc('my-vpc') do
  it { should exist }
  it { should be_available }
end
