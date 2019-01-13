RSpec::Matchers.define :have_env_var do |env_var|
  match do |lambda_function|
    lambda_function.environment.variables.key?(env_var)
  end

  description do
    'exist'
  end
end
