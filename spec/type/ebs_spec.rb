require 'spec_helper'
Awspec::Stub.load 'ebs'

describe ebs('my-volume') do
  it { should exist }
  it { should be_in_use }
  its(:size) { should eq 100 }
  it { should be_attached_to('my-ec2') }
end
