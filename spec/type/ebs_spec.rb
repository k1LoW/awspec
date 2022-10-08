# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'ebs'

describe ebs('my-volume') do
  it { should exist }
  it { should be_in_use }
  its(:size) { should eq 100 }
  its(:volume_type) { should eq 'gp2' }
  it { should be_attached_to('my-ec2') }
  it { should have_tag('Name').value('my-volume') }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('resource.size') { should eq 100 }
    its('attachments.first.instance_id') { should eq 'i-ec12345a' }
  end
end
