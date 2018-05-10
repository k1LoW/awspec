require 'spec_helper'
Awspec::Stub.load 'organizations_account'

describe organizations_account('Master Account') do
  it { should exist }
  its(:id) { should eq '111111111111' }
  its(:name) { should eq 'Master Account' }
  its(:status) { should eq 'ACTIVE' }
  its(:joined_method) { should eq 'CREATED' }
end

describe organizations_account('Member Account2') do
  it { should exist }
  its(:id) { should eq '222222222222' }
  its(:name) { should eq 'Member Account2' }
  its(:status) { should eq 'ACTIVE' }
  its(:joined_method) { should eq 'INVITED' }
end
