RSpec::Matchers.define :have_env_vars do
  match do |lambda_function|
    !lambda_function.environment.variables.empty?
  end
end
