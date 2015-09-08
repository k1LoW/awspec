require 'spec_helper'
Awspec::Stub.load 'iam_policy'

describe iam_policy('my-iam-policy') do
  it { should exist }
  it { should be_attachable }
  its(:arn) { should eq 'arn:aws:iam::aws:policy/my-iam-policy' }
  its(:attachment_count) { should eq 1 }
  its(:policy_id) { should eq 'PABCDEFGHI123455689' }
  its(:policy_name) { should eq 'my-iam-policy' }
end
