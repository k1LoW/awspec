require 'spec_helper'
Awspec::Stub.load 'iam_role'

describe iam_role('my-iam-role') do
  it { should exist }
  it { should have_iam_policy('ReadOnlyAccess') }
end
