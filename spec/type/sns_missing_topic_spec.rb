# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'sns_topic_error'

describe sns_topic(TOPIC_ARN) do
  it { should_not exist }
  its(:name) { will raise_error(Awspec::NoExistingResource) }
  its(:confirmed_subscriptions) { will raise_error(Awspec::NoExistingResource) }
  its(:pending_subscriptions) { will raise_error(Awspec::NoExistingResource) }
  its(:topic_arn) { will raise_error(Awspec::NoExistingResource) }
  its(:display_name) { will raise_error(Awspec::NoExistingResource) }
  its(:deleted_subscriptions) { will raise_error(Awspec::NoExistingResource) }
  its(:subscriptions) { will raise_error(Awspec::NoExistingResource) }
  its(:id) { will_not raise_error }
  its(:id) { should be_nil }

  it 'include_subscribed matcher raises Awspec::NoExistingResource' do
    expect { should include_subscribed(TOPIC_SUBS_ARN) }.to raise_error(Awspec::NoExistingResource)
  end

  let(:expected_attribs) do
    { protocol: 'lambda',
      owner: OWNER,
      subscription_arn: TOPIC_SUBS_ARN, # this is required
      endpoint: "arn:aws:lambda:#{REGION}:#{OWNER}:function:foobar" }
  end

  it 'have_subscription_attributes matcher raises Awspec::NoExistingResource' do
    expect { should have_subscription_attributes(expected_attribs) }.to raise_error(Awspec::NoExistingResource)
  end
end
