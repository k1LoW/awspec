require 'spec_helper'
Awspec::Stub.load 's3'

describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
end

describe s3('my-bucket') do
  its('resource.acl.owner.display_name') { should eq 'my-bucket-owner' }
end
