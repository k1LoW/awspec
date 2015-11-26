require 'spec_helper'
Awspec::Stub.load 's3_bucket_acl'

describe s3_bucket_acl('my-s3-bucket-acl') do
  it { should exist }
end
