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
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
    POLICY
  end

  context "nested attribute call" do
    its(:real_resource) {
      should be_an_instance_of(Awspec::ResourceReader)
    }

    its('real_resource.name') { should eq "my-bucket" }
    its('real_resource.acl')  {
      should be_an_instance_of(Awspec::ResourceReader)
    }
    it {
      expect(subject.real_resource.acl.instance_variable_get(:@resource)).to be_an_instance_of(Aws::S3::BucketAcl)
    }

    it 'should be a Exception when black list method is called' do
      expect{ subject.real_resource.delete }.to raise_error(
        Awspec::ResourceReader::CalledMethodInBlackList,
        "Method call :delete is black-listed"
      )
    end

    its('real_resource.acl.owner.display_name') { should eq "my-bucket-owner" }
  end
end

# deprecated
describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'http://acs.amazonaws.com/groups/s3/LogDelivery', permission: 'WRITE') }
  it { should have_acl_grant(grantee: '68f4bb06b094152df53893bfba57760e', permission: 'READ') }
  its(:acl_owner) { should eq 'my-bucket-owner' }
end
