RSpec::Matchers.define :have_rule do |rule_id|
  match do |type|
    return type.has_rule?(rule_id, @priority, @action) if type.instance_of?(Awspec::Type::WafWebAcl)
    return type.has_rule?(rule_id, @priority, @action) if type.instance_of?(Awspec::Type::WafregionalWebAcl)
    return type.has_rule?(rule_id, @priority, @conditions, @actions) if type.instance_of?(Awspec::Type::AlbListener)
    type.has_rule?(rule_id, @priority, @conditions, @actions) if type.instance_of?(Awspec::Type::NlbListener)
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

  chain :conditions do |conditions|
    @conditions = conditions
  end

  chain :actions do |actions|
    @actions = actions
  end

  chain :if do |conditions|
    @conditions = conditions
  end

  chain :then do |actions|
    @actions = actions
  end
end
