require 'spec_helper'
Awspec::Stub.load 'network_interface'

describe network_interface('eni-12ab3cde') do
  it { should exist }
  its(:network_interface_id) { should eq 'eni-12ab3cde' }
  it { should be_in_use }
  it { should be_attached_to('my-ec2').as_eth0 }
  it { should belong_to_subnet('my-subnet') }
  it { should belong_to_vpc('my-vpc') }
  it { should have_security_group('my-security-group-name') }
  it { should have_private_ip_address('10.0.1.1').primary }
  it { should have_private_ip_address('10.0.1.2') }
  its(:private_ip_addresses_count) { should eq 2 }
end

describe network_interface('my-eni') do
  it { should exist }
  it { should have_tag('Name').value('my-eni') }
end
