RSpec::Matchers.define :be_allowed_action do |action_name|
  match do |resource|
    results = resource.select_policy_evaluation_results(resource.resource[:arn], action_name, @resource_arn)
    results.find do |result|
      result.eval_decision == 'allowed'
    end
  end

  chain :resource_arn do |arn|
    @resource_arn = arn
  end
end
