require 'spec_helper'
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

  it { should include_subscribed(SUBSCRIBED) }
  it { should have_subscription_attributes(expected_attribs) }
end
