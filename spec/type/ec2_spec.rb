# frozen_string_literal: true

require 'spec_helper'

describe 'single security group' do
  before do
    Awspec::Stub.load 'ec2'
  end

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
    it { should have_network_interface('eni-12ab3cde') }
    it { should have_network_interface('my-eni').as_eth1 }
    its(:private_ip_address) { should eq '10.0.1.1' }
    its(:security_group_count) { should eq 1 }
    context 'nested attribute call' do
      its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
      its('vpc.id') { should eq 'vpc-ab123cde' }
    end
    it { should have_tag('Name').value('my-ec2') }
    it { should have_iam_instance_profile('Ec2IamProfileName') }
    it { should have_credit_specification('unlimited') }
  end

  describe ec2('my-ec2') do
    it { should exist }
    it { should be_running }
    it { should have_tag('Name').value('my-ec2') }
  end

  describe ec2('my-ec2-classic') do
    it { should have_classiclink('my-vpc') }
    it { should have_classiclink_security_group('sg-2a3b4cd5') }
    it { should have_classiclink_security_group('my-vpc-security-group-name') }
  end
end

describe 'multi security group' do
  before do
    Awspec::Stub.load 'ec2_has_multi_security_groups'
  end

  describe ec2('i-ec12345a') do
    its(:security_group_count) { should eq 2 }
    it { should have_security_groups(['sg-1a2b3cd4', 'sg-5e6f7gh8']) }
    it { should have_security_groups(['my-security-group-name', 'my-security-group-name-2']) }
    it { should have_security_groups(['my-security-group-tag-name', 'my-security-group-tag-name-2']) }
  end
end

describe ec2('non-existing-ec2') do
  before do
    Awspec::Stub.load 'ec2_non_existing'
  end

  it { should_not exist }
  methods = %w[running? instance_id image_id public_ip_address private_ip_address have_eip
               security_group_count resource_security_groups]

  methods.each do |method_name|
    it "#{method_name} raises Awspec::NoExistingResource" do
      expect { subject.send(method_name) }.to raise_error(Awspec::NoExistingResource)
    end
  end
end
