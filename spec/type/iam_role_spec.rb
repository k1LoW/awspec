require 'spec_helper'
Awspec::Stub.load 'iam_role'

describe iam_role('my-iam-role') do
  it { should exist }
  it { should have_iam_policy('ReadOnlyAccess') }
  it { should have_inline_policy }
  it { should have_inline_policy('AllowS3BucketAccess') }
  it do
    should have_inline_policy('AllowS3BucketAccess').policy_document(<<-'DOC')
{
"Statement": [
    {
     "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
    }
  ]
}
DOC
  end
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('ec2:DescribeInstances').resource_arn('*') }
  it do
    should be_allowed_action('s3:ListBucket')
      .resource_arn('*')
      .context_entries(
        [{ context_key_name: 's3:prefix', context_key_values: ['/file.txt'], context_key_type: 'string' }])
  end
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('resource.role_name') { should eq 'my-iam-role' }
    its('attached_policies.count') { should eq 1 }
  end
end
