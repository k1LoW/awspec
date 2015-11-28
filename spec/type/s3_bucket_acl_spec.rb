require 'spec_helper'
Awspec::Stub.load 's3_bucket_acl'

describe s3_bucket_acl('my-bucket') do
  it { should exist }
  it { should belong_to_owner(display_name: 'owner') }
  it { should have_grant(permission: 'FULL_CONTROL', grantee: { display_name: 'grantee' }) }
end
