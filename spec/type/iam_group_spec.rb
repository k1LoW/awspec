require 'spec_helper'
Awspec::Stub.load 'iam_group'

describe iam_group('my-iam-group') do
  it { should exist }
  it { should have_iam_user('my-iam-user') }
  it { should have_iam_policy('ReadOnlyAccess') }
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('ec2:DescribeInstances').resource_arn('*') }
end
