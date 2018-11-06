require 'spec_helper'
Awspec::Stub.load 'sns_topic'

topic_arn = 'arn:aws:sns:us-east-1:123456789:foobar'

describe sns_topic(topic_arn) do
  it { should exist }
  its(:confirmed_subscriptions) { should eq 2 }
  its(:pending_subscriptions) { should eq 0 }
  its(:topic_arn) { should eq topic_arn }
  its(:display_name) { should eq 'Useless' }
  its(:deleted_subscriptions) { should eq 0 }
end
