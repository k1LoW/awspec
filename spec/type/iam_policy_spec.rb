require 'spec_helper'
Awspec::Stub.load 'iam_policy'

describe iam_policy('my-iam-policy') do
  it { should exist }
  it { should be_attachable }
end
