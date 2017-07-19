require 'spec_helper'
Awspec::Stub.load 'lambda'

describe lambda('my-lambda-function-name') do
  it { should exist }
  its(:description) { should eq 'My lambda function' }
  its(:runtime) { should eq 'python2.7' }
  its(:handler) { should eq 'lambda_function.lambda_handler' }
  its(:code_size) { should eq 1234 }
  its(:timeout) { should eq 5 }
  its(:memory_size) { should eq 256 }
  its(:role) { should eq 'arn:aws:iam::123456789000:role/lambda_role' }

  its(:environment) { should include 'key_a' => 'value_a', 'key_b' => 'value_b' }
end

# Check there are multiple lambdas returned by the list function
describe lambda('my-other-lambda-function-name') do
  it { should exist }
end

describe lambda('not-exist-function') do
  it { should_not exist }
end
