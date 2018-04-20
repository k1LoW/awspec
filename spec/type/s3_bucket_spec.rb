require 'spec_helper'
Awspec::Stub.load 's3_bucket'

describe s3_bucket('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }

  its(:acl_owner) { should eq 'my-bucket-owner' }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'http://acs.amazonaws.com/groups/s3/LogDelivery', permission: 'WRITE') }
  it { should have_acl_grant(grantee: '68f4bb06b094152df53893bfba57760e', permission: 'READ') }

  its(:cors_rules_count) { should eq 2 }
  it do
    should have_cors_rule(
      allowed_methods: ['GET'],
      allowed_origins: ['*']
    )
  end
  it do
    should have_cors_rule(
      allowed_headers: ['*'],
      allowed_methods: ['GET'],
      allowed_origins: ['https://example.org', 'https://example.com'],
      expose_headers:  ['X-Custom-Header'],
      max_age_seconds: 3600
    )
  end

  it do
    should have_policy <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": { "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity XXXXX" },
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::my-bucket/*",
        "arn:aws:s3:::my-bucket"
      ]
    }
  ]
}
    POLICY
  end

  it { should have_logging_enabled(target_bucket: 'my-log-bucket', target_prefix: 'logs/') }

  it { should have_tag('env').value('dev') }

  it { should have_versioning_enabled }

  it { should have_mfa_delete_enabled }

  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('resource.name') { should eq 'my-bucket' }
    its('resource.acl') { should be_an_instance_of(Awspec::ResourceReader) }
    its(:acl) { should be_an_kind_of(Awspec::ResourceReader) }
    it 'should be a Exception when black list method is called' do
      expect { subject.delete }.to raise_error(
        Awspec::BlackListForwardable::CalledMethodInBlackList,
        'Method call :delete is black-listed'
      )
    end

    its('acl.owner.display_name') { should eq 'my-bucket-owner' }
  end
end

describe s3_bucket('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'http://acs.amazonaws.com/groups/s3/LogDelivery', permission: 'WRITE') }
  it { should have_acl_grant(grantee: '68f4bb06b094152df53893bfba57760e', permission: 'READ') }
  its(:acl_owner) { should eq 'my-bucket-owner' }
end

describe s3_bucket('my-bucket') do
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
end
