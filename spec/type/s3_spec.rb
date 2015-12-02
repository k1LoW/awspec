require 'spec_helper'
Awspec::Stub.load 's3'

describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
  its(:acl_grant_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'my-bucket-write-only', permission: 'WRITE') }
  it { should have_acl_grant(grantee: 'my-bucket-read-only', permission: 'READ') }
  its(:acl_owner) { should eq 'my-bucket-owner' }
end
