require 'spec_helper'
Awspec::Stub.load 'iam_group'

describe iam_group('my-iam-group') do
  it { should exist }
end
