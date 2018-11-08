require 'spec_helper'
Awspec::Stub.load 'sns_topic'

topic_arn = 'arn:aws:sns:us-east-1:123456789:foobar'
subscribed = 'arn:aws:sns:us-east-1:123456789:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca'

describe sns_topic(topic_arn) do
  it { should exist }
  its(:confirmed_subscriptions) { should eq 1 }
  its(:pending_subscriptions) { should eq 0 }
  its(:topic_arn) { should eq topic_arn }
  its(:display_name) { should eq 'Useless' }
  its(:deleted_subscriptions) { should eq 0 }
  it { should include_subscribed(subscribed) }

  let(:sub) { subject.subscribed(subscribed) }

  describe "#subscribed #{subscribed}" do
    it do
      expect(sub).to have_attributes({  protocol: 'lambda',
                                        owner: '123456789',
                                        endpoint: 'arn:aws:lambda:us-east-1:123456789:function:foobar',
                                        topic_arn: 'arn:aws:sns:us-east-1:123456789:foobar' })
    end
  end
end
