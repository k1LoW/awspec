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
  it do
    should have_lifecycle_rule(
      id: 'MyRuleName',
      noncurrent_version_expiration: { noncurrent_days: 1 },
      expiration: { days: 2 },
      transitions: [{ days: 3, storage_class: 'GLACIER' }],
      status: 'Enabled'
    )
  end
  it do
    should have_lifecycle_rule(
      id: 'MyRuleName2',
      filter: { prefix: '123/' },
      noncurrent_version_expiration: { noncurrent_days: 2 },
      expiration: { days: 3 },
      transitions: [{ days: 5, storage_class: 'STANDARD_IA' }, { days: 10, storage_class: 'GLACIER' }],
      status: 'Enabled'
    )
  end
  it { should have_location('ap-northeast-1') }
end
EOF
    expect(s3_bucket.generate_all.to_s).to eq spec
    expect(s3_bucket.generate('my-bucket').to_s).to eq spec
  end
end
