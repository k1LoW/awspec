require 'spec_helper'
Awspec::Stub.load 'iam_group'

describe iam_group('my-iam-group') do
  it { should exist }
  it { should have_iam_user('my-iam-user') }
  it { should have_iam_policy('ReadOnlyAccess') }
  it { should have_inline_policy('InlineEC2FullAccess') }
  it do
    should have_inline_policy('InlineEC2FullAccess').policy_document(<<-'DOC')
{
  "Statement": [
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:*",
      "Resource": "*"
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
    its('users.first.user_name') { should eq 'my-iam-user' }
  end
end
