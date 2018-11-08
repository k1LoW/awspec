RSpec::Matchers.define :include_subscribed do |subscribed_arn|
  match do |sns_topic|
    sns_topic.has_subscription?(subscribed_arn)
  end
end
