require 'spec_helper'
Awspec::Stub.load 'vpn_connection'

describe vpn_connection('vpn-cg5692g4') do
  it { should exist }
  it { should be_available }
  its(:vpn_gateway_id) { should eq 'vgw-cg5692g4' }
  its(:customer_gateway_id) { should eq 'cgw-cg5692g4' }
  its(:type) { should eq 'ipsec.1' }
end
