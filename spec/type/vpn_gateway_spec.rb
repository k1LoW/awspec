# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'vpn_gateway'

describe vpn_gateway('vgw-cg5692g4') do
  it { should exist }
  it { should be_available }
  its(:availability_zone) { should eq 'us-east-1a' }
  its(:type) { should eq 'ipsec.1' }
end

describe vpn_gateway('my-vpn-gateway') do
  it { should exist }
  it { should be_available }
  its(:availability_zone) { should eq 'us-east-1a' }
  its(:type) { should eq 'ipsec.1' }
  it { should belong_to_vpc('vpc-ab123cde') }
  its(:amazon_side_asn) { should eq 64_512 }
  it { should have_tag('Name').value('my-vpn-gateway') }
end
