require 'spec_helper'

OWNER = '123456789'
REGION = 'us-east-1'
TOPIC_ARN = "arn:aws:sns:#{REGION}:#{OWNER}:foobar"
SUBSCRIBED = "arn:aws:sns:#{REGION}:#{OWNER}:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca"
ENDPOINT = "arn:aws:lambda:#{REGION}:#{OWNER}:function:foobar"
DISPLAY_NAME = 'Useless'

Awspec::Stub.load 'sns_topic'

describe sns_topic(TOPIC_ARN) do
  it { should exist }
  its(:name) { should eq 'foobar' }
  its(:confirmed_subscriptions) { should eq 1 }
  its(:pending_subscriptions) { should eq 0 }
  its(:topic_arn) { should eq TOPIC_ARN }
  its(:display_name) { should eq DISPLAY_NAME }
  its(:deleted_subscriptions) { should eq 0 }
  its(:subscriptions) { should eql([SUBSCRIBED.to_sym]) }
  its(:id) { should eq TOPIC_ARN }

  let(:expected_attribs) do
    { protocol: 'lambda',
      owner: OWNER,
      subscription_arn: SUBSCRIBED, # this is required
      endpoint: ENDPOINT }
  end

  describe '#include_subscribed' do
    it { should include_subscribed(SUBSCRIBED) }
  end

  describe '#subscribed' do
    it do
      should have_subscription_attributes(expected_attribs)
    end
  end
end
