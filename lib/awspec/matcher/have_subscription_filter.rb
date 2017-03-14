RSpec::Matchers.define :have_subscription_filter do |filter_name|
  match do |log_group_name|
    log_group_name.has_subscription_filter?(filter_name, @pattern)
  end

  chain :filter_pattern do |pattern|
    @pattern = pattern
  end
end
