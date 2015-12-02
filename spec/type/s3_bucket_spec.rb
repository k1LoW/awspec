require 'spec_helper'
Awspec::Stub.load 's3_bucket'

describe s3_bucket('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'my-bucket-write-only', permission: 'WRITE') }
  it { should have_acl_grant(grantee: 'my-bucket-read-only', permission: 'READ') }
  its(:acl_owner) { should eq 'my-bucket-owner' }
end

# deprecated
describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'my-bucket-write-only', permission: 'WRITE') }
  it { should have_acl_grant(grantee: 'my-bucket-read-only', permission: 'READ') }
  its(:acl_owner) { should eq 'my-bucket-owner' }
end
