require 'spec_helper'
Awspec::Stub.load 'sns_topic'

# based on values from lib/awspec/sub/sns_topic.rb
topic_arn = 'arn:aws:sns:us-east-1:123456789:foobar'
subscribed = 'arn:aws:sns:us-east-1:123456789:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca'

describe sns_topic(topic_arn) do
  it { should exist }
  its(:name) { should eq 'foobar' }
  its(:confirmed_subscriptions) { should eq 1 }
  its(:pending_subscriptions) { should eq 0 }
  its(:topic_arn) { should eq topic_arn }
  its(:display_name) { should eq 'Useless' }
  its(:deleted_subscriptions) { should eq 0 }
  it { should include_subscribed(subscribed) }

  let(:expected_attribs) do
    { protocol: 'lambda',
      owner: '123456789',
      subscription_arn: subscribed, # this is required
      endpoint: 'arn:aws:lambda:us-east-1:123456789:function:foobar' }
  end

  describe '#subscribed' do
    it do
      should have_subscription_attributes(expected_attribs)
    end
  end
end
