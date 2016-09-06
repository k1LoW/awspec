RSpec::Matchers.define :have_rule do |rule_id|
  match do |web_acl|
    web_acl.has_rule?(rule_id, @priority, @action)
  end

  chain :priority do |priority|
    @priority = priority
  end

  chain :order do |priority|
    @priority = priority
  end

  chain :action do |action|
    @action = action
  end
end
