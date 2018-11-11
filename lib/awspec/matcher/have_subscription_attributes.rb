RSpec::Matchers.define :have_subscription_attributes do |expected_attribs|
  match do |sns_topic|
    unless expected_attribs.key?(:subscription_arn)
      raise '"subscription_arn" is the only required attribute to validate'
    end
    subscribed = sns_topic.subscribed(expected_attribs[:subscription_arn])
    temp = subscribed.to_h
    to_remove = temp.keys - expected_attribs.keys
    to_remove.each { |key| temp.delete(key) }
    temp == expected_attribs
  end

  failure_message do |sns_topic|
    "expected SNS topic #{sns_topic.name} to have a subscription with the following attributes: #{expected_attribs}"
  end
end
