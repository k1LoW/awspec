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
  its(:subscriptions) { should eql([:"arn:aws:sns:us-east-1:123456789:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca"]) }
  its(:id) { should eq 'arn:aws:sns:us-east-1:123456789:foobar' }

  let(:expected_attribs) do
    { protocol: 'lambda',
      owner: '123456789',
      subscription_arn: subscribed, # this is required
      endpoint: 'arn:aws:lambda:us-east-1:123456789:function:foobar' }
  end

  describe '#include_subscribed' do
    it { should include_subscribed(subscribed) }
  end

  describe '#subscribed' do
    it do
      should have_subscription_attributes(expected_attribs)
    end
  end
end

invalid_topic_arn = 'arn:aws:sns:us-east-1:123456789:invalid'

describe sns_topic(invalid_topic_arn) do
  context 'Issue https://github.com/k1LoW/awspec/issues/445 is still open' do
    it 'it does not exists'
    it ':name raises Awspec::NoExistingResource'
    it ':confirmed_subscriptions raises Awspec::NoExistingResource'
    it ':pending_subscriptions raises Awspec::NoExistingResource'
    it ':topic_arn raises Awspec::NoExistingResource'
    it ':display_name raises Awspec::NoExistingResource'
    it ':deleted_subscriptions raises Awspec::NoExistingResource'
    it ':subscriptions raises Awspec::NoExistingResource'
    it ':id raises Awspec::NoExistingResource'
    it 'matcher include_subscribed raises Awspec::NoExistingResource'
    it 'matcher have_subscription_attributes raises Awspec::NoExistingResource'
  end
end
