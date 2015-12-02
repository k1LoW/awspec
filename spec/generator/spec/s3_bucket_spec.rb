require 'spec_helper'

describe Awspec::Generator::Spec::S3Bucket do
  before do
    Awspec::Stub.load 's3_bucket'
  end
  let(:s3_bucket) { Awspec::Generator::Spec::S3Bucket.new }
  it 'generates spec' do
    spec = <<-'EOF'
describe s3_bucket('my-bucket') do
  it { should exist }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'my-bucket-write-only', permission: 'WRITE') }
  it { should have_acl_grant(grantee: 'my-bucket-read-only', permission: 'READ') }
  its(:acl_owner) { should eq 'my-bucket-owner' }
end
EOF
    expect(s3_bucket.generate_all.to_s).to eq spec
  end
end
