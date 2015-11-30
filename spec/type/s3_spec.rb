require 'spec_helper'
Awspec::Stub.load 's3'

describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
  it { should have_acl(grantee: 'my-bucket-grantee', permission: 'FULL_CONTROL') }
  it { should have_acl(grantee: 'my-bucket-grantee', permission: 'FULL_CONTROL', type: 'CanonicalUser') }
  its(:bucket_acl_owner) { should eq 'my-bucket-owner' }
end
