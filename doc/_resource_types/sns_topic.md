### Common arguments

`topic_arn` is a string of the ARN of the SNS Topic.

`subscribed` is a string of the SNS Topic subscription ARN.

### exist

```ruby
describe sns_topic(topic_arn) do
  it { should exist }
end
```

### name

```ruby
describe sns_topic(topic_arn) do
  its(:name) { should eq 'foobar' }
end
```

### confirmed_subscriptions

```ruby
describe sns_topic(topic_arn) do
  its(:confirmed_subscriptions) { should eq 1 }
end
```

### pending_subscriptions

```ruby
describe sns_topic(topic_arn) do
  its(:pending_subscriptions) { should eq 0 }
end
```

### topic_arn

```ruby
describe sns_topic(topic_arn) do
  its(:topic_arn) { should eq topic_arn }
end
```

### display_name

```ruby
describe sns_topic(topic_arn) do
  its(:display_name) { should eq 'ShortName' }
end
```

### deleted_subscriptions

```ruby
describe sns_topic(topic_arn) do
  its(:deleted_subscriptions) { should eq 0 }
end
```

### subscriptions

More like a helper method for fixtures. You could add any logic required to
identify a specific method.

```ruby
let (:subscriber) do
  all = subject.subscriptions
  return all[0].to_s # keys are stored as symbols
end
```

### include_subscribed

```ruby
describe sns_topic(topic_arn) do
  it { should include_subscribed(subscribed) }
end
```

### have_subscription

```ruby
describe sns_topic(topic_arn) do
  let(:subscription_arn) do
      subscription_arn: subscribed, # this is required
  end

  describe '#subscribed' do
    it do
      should have_subscription(subscribed)
    end
  end
end
```

An [automatic matcher](https://www.rubydoc.info/github/rspec/rspec-expectations/RSpec/Matchers) created due the predicate `has_subscription?` existing method of `Awspec::Type::SnsTopic` class.

It validates if a given AWS SNS ARN subscription exists in the SNS Topic.

### have_subscription_attributes

```ruby
describe sns_topic(topic_arn) do
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
```

Where `:expected_attribs` is a hash with keys as properties that are part of a SNS Topic subscription:

* subscription_arn
* owner
* protocol
* endpoint
* topic_arn

You can use any combinations of key/values that will be used by `have_subscription_attributes`, but the `subscription_arn` is required and if it is missing, an exception will be generated.

### advanced

You may want to validate the subscriptions too. For that, you probably will want to  use the methods `subscriptions` (that will return a list of the subscriptions ARN as symbols) and `has_subscription?` (that expects a SNS Topic subscription as parameter and will return `true` of `false` if it exists as a subscription) of the class `Awspec::Type::SnsTopic` to build the fixture in order to use the matcher `have_subscription_attributes`.
