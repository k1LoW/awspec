### exist

```ruby
describe lambda('my-lambda-function-name') do
  it { should exist }
end
```

### have_env_vars

Useful to validate if there are environment variables configured in the Lambda:

```ruby
describe lambda('my-lambda-function-name') do
  it { should have_env_vars() }
end
```

### have_env_var

Useful to validate if there is a specific environment variable declared in the Lambda. You probably will want to use it with `have_env_var_value`.

## have_env_var_value

Validates if a specific environment variable has the expected value. More useful to use with `have_env_var` because if the variable isn't available, it will fail without notifying that the variable is missing.

```ruby
expected.each_pair do |key, value|
  context "environment variable #{key}" do
    it { should have_env_var(key) }
    it { should have_env_var_value(key, value) }
  end
end
```

`expected` would be a hash that has the environment variables names as keys.

### have_event_source

This matcher does not support Amazon S3 event sources ([see SDK doc](http://docs.aws.amazon.com/sdkforruby/api/Aws/Lambda/Client.html#list_event_source_mappings-instance_method)).
