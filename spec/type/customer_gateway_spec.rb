require 'spec_helper'
Awspec::Stub.load 'customer_gateway'

describe customer_gateway('cgw-cg5692g4') do
  it { should exist }
  it { should be_available }
  its(:ip_address) { should eq '1.1.1.1' }
  its(:type) { should eq 'ipsec.1' }
  its(:bgp_asn) { should eq '65000' }
end
