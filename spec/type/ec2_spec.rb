require 'spec_helper'
Awspec::Stub.load 'ec2'

describe ec2('i-ec12345a') do
  it { should exist }
  it { should be_running }
  it { should have_event('system-reboot') }
  it { should have_events }
  it { should_not be_stopped }
  its(:instance_id) { should eq 'i-ec12345a' }
  its(:image_id) { should eq 'ami-abc12def' }
  its(:public_ip_address) { should eq '123.0.456.789' }
  its(:private_ip_address) { should eq '10.0.1.1' }
  it { should be_disabled_api_termination }
  it { should have_security_group('sg-1a2b3cd4') }
  it { should have_security_group('my-security-group-name') }
  it { should have_security_group('my-security-group-tag-name') }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('subnet-1234a567') }
  it { should belong_to_subnet('my-subnet') }
  it { should have_eip }
  it { should have_eip('123.0.456.789') }
  it { should have_ebs('vol-123a123b') }
  it { should have_ebs('my-volume') }
  its(:private_ip_address) { should eq '10.0.1.1' }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('vpc.id') { should eq 'vpc-ab123cde' }
  end
  it { should have_tag('Name').value('my-ec2') }
end

describe ec2('my-ec2') do
  it { should exist }
  it { should be_running }
  it { should have_tag('Name').value('my-ec2') }
end
