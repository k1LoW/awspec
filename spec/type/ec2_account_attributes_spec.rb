require 'spec_helper'
Awspec::Stub.load 'ec2_account_attributes'

describe ec2_account_attributes do
  its(:supported_platforms) { should include 'VPC' }
  its(:max_instances) { should eq 20 }
end
