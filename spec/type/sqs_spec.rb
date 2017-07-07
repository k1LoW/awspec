require 'spec_helper'
Awspec::Stub.load 'sqs'

describe sqs('my-queue') do
  it { should exist }
  its(:queue_url) { should eq 'https://sqs.ap-northeast-1.amazonaws.com/123456789012/my-queue' }
  its(:queue_arn) { should eq 'arn:aws:sqs:ap-northeast-1:123456789012:my-queue' }
end
