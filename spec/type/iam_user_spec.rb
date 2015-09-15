require 'spec_helper'
Awspec::Stub.load 'iam_user'

describe iam_user('my-iam-user') do
  it { should exist }
  it { should belong_to_iam_group('my-iam-group') }
  it { should have_iam_policy('ReadOnlyAccess') }
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('ec2:DescribeInstances').resource_arn('*') }
end
