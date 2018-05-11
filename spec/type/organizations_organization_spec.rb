require 'spec_helper'
Awspec::Stub.load 'organizations_organization'

describe organizations_organization('o-exampleorgid') do
  it { should exist }
  its(:id) { should eq 'o-exampleorgid' }
  its(:feature_set) { should eq 'ALL' }
  its(:master_account_id) { should eq '111111111111' }
  it { should be_service_control_policy_enabled }
end
