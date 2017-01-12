require 'spec_helper'
Awspec::Stub.load 'vpn_gateway'

describe vpn_gateway('vgw-cg5692g4') do
  it { should exist }
  it { should be_available }
  its(:availability_zone) { should eq 'us-east-1a' }
  its(:type) { should eq 'ipsec.1' }
end
