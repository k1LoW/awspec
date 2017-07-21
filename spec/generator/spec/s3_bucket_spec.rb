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
  its(:acl_owner) { should eq 'my-bucket-owner' }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'http://acs.amazonaws.com/groups/s3/LogDelivery', permission: 'WRITE') }
  it { should have_acl_grant(grantee: '68f4bb06b094152df53893bfba57760e', permission: 'READ') }
  it { should have_policy('{"Version":"2012-10-17","Statement":[{"Sid":"","Effect":"Allow","Principal":{"AWS":"arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity XXXXX"},"Action":"s3:*","Resource":["arn:aws:s3:::my-bucket","arn:aws:s3:::my-bucket/*"]}]}') }
  it { should have_tag('env').value('dev') }
end
EOF
    expect(s3_bucket.generate_all.to_s).to eq spec
    expect(s3_bucket.generate('my-bucket').to_s).to eq spec
  end
end
