require 'spec_helper'
Awspec::Stub.load 'directconnect_virtual_interface'

describe directconnect_virtual_interface('my-directconnect-virtual-interface') do
  it { should exist }
  it { should be_available }
  its(:connection_id) { should eq 'dxcon-abcd5fgh' }
  its(:virtual_interface_id) { should eq 'dxvif-aabbccdd' }
  its(:amazon_address) { should eq '170.252.252.1/30' }
  its(:customer_address) { should eq '123.456.789.2/30' }
  its(:virtual_gateway_id) { should eq 'vgw-d234e5f6' }
end
