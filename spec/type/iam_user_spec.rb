require 'spec_helper'
Awspec::Stub.load 'iam_user'

describe iam_user('my-iam-user') do
  it { should exist }
  it { should belong_to_iam_group('my-iam-group') }
  it { should have_iam_policy('ReadOnlyAccess') }
end
