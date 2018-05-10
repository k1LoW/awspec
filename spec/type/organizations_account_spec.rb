require 'spec_helper'
Awspec::Stub.load 'organizations_account'

describe organizations_account('Master Account') do
  it { should exist }
  its(:id) { should eq '111111111111' }
  its(:name) { should eq 'Master Account' }
  it { should be_active }
  it { should_not be_suspended }
  it { should be_created }
  it { should_not be_invited }
end

describe organizations_account('Member Account2') do
  it { should exist }
  its(:id) { should eq '222222222222' }
  its(:name) { should eq 'Member Account2' }
  it { should be_active }
  it { should_not be_suspended }
  it { should be_invited }
  it { should_not be_created }
end
