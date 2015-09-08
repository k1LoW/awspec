require 'spec_helper'
Awspec::Stub.load 'iam_group'

describe iam_group('my-iam-group') do
  it { should exist }
  it { should have_iam_user('my-iam-user') }
  it { should have_iam_policy('ReadOnlyAccess') }
end
