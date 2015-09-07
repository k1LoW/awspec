require 'spec_helper'
Awspec::Stub.load 'iam_role'

describe iam_role('my-iam-role') do
  it { should exist }
end
