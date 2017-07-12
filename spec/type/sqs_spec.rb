require 'spec_helper'
Awspec::Stub.load 'sqs'

describe sqs('my-queue') do
  it { should exist }
end
