RSpec::Matchers.define :be_allowed_action do |action_name|
  match do |type|
    results = type.select_policy_evaluation_results(type.resource_via_client[:arn],
                                                    action_name,
                                                    @resource_arn,
                                                    @context_entries)
    results.find do |result|
      result.eval_decision == 'allowed'
    end
  end

  chain :resource_arn do |arn|
    @resource_arn = arn
  end

  chain :context_entries do |context|
    @context_entries = context
  end
end
