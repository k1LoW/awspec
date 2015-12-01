require 'spec_helper'
Awspec::Stub.load 's3'

describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
  its(:bucket_acl_grant_count) { should eq 3 }
  it { should have_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL', grantee_type: 'CanonicalUser') }
  it { should have_grant(grantee: 'my-bucket-write-only', permission: 'WRITE', grantee_type: 'CanonicalUser') }
  it { should have_grant(grantee: 'my-bucket-read-only', permission: 'READ', grantee_type: 'CanonicalUser') }
  its(:bucket_acl_owner) { should eq 'my-bucket-owner' }
end

describe s3('my-bucket') do
  it { should have_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
end
