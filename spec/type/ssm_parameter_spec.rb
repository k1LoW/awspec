require 'spec_helper'
Awspec::Stub.load 'ssm_parameter'

describe ssm_parameter('my-parameter') do
  it { should exist }
  it { should be_encrypted }
  its(:version) { should be_eql(1) }
  its(:arn) { should be_eql('arn:aws:ssm:REGION:ACCOUNT_ID:parameter/my-parameter') }
  its(:value) { should be_eql('encrypted') }
end
