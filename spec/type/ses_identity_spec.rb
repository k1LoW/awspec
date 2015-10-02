require 'spec_helper'
Awspec::Stub.load 'ses_identity'

describe ses_identity('example.com') do
  it { should exist }
  it { should have_identity_policy('my-identity-policy-name') }
  its(:dkim_enabled) { should eq false }
  its(:dkim_verification_status) { should eq 'NotStarted' }
  its(:bounce_topic) { should eq 'arn:aws:sns:us-east-1:1234567890:my-sns-topic' }
  its(:verification_status) { should eq 'Success' }
end
