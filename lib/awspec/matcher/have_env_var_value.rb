RSpec::Matchers.define :have_env_var_value do |env_var, value|
  match do |lambda_function|
    if lambda_function.environment.variables.key?(env_var)
      lambda_function.environment.variables[env_var] == value
    else
      false
    end
  end

  description do
    "have the value #{value}"
  end

  failure_message do |lambda_function|
    current_value = lambda_function.environment.variables[env_var]
    "Environment variable #{env_var} don't have the value #{value}, but #{current_value}"
  end
end
