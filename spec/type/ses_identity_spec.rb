require 'spec_helper'
Awspec::Stub.load 'ses_identity'

describe ses_identity('example.com') do
  it { should exist }
  it { should have_identity_policy('my-identity-policy-name') }
end
