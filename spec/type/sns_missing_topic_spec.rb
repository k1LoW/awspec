require 'spec_helper'

TOPIC_ARN = 'arn:aws:sns:us-east-1:123456789:invalid'
TOPIC_SUBS_ARN = 'arn:aws:sns:us-east-1:123456789:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca'

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
  it 'has_subscription raises Awspec::NoExistingResource' do
    expect { subject.has_subscription?(TOPIC_SUBS_ARN) }.to raise_error(Awspec::NoExistingResource)
  end

  let(:expected_attribs) do
    { protocol: 'lambda',
      owner: '123456789',
      subscription_arn: TOPIC_SUBS_ARN, # this is required
      endpoint: 'arn:aws:lambda:us-east-1:123456789:function:foobar' }
  end

  it 'have_subscription_attributes raises Awspec::NoExistingResource' do
    expect { should have_subscription_attributes(expected_attribs) }.to raise_error(Awspec::NoExistingResource)
  end
end
