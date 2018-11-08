RSpec::Matchers.define :include_subscribed do |subscriber_arn|
  match do |sns_topic|
    sns_topic.list_subscriptions.has_key?(subscriber_arn.to_sym)
  end
end
