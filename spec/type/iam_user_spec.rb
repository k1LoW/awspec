require 'spec_helper'
Awspec::Stub.load 'iam_user'

describe iam_user('my-iam-user') do
  it { should exist }
end
