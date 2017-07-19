require 'spec_helper'
Awspec::Stub.load 'lambda'

describe lambda('my-lambda-function-name') do
  it { should exist }
  its(:description) { should eq 'this is a description' }
  its(:runtime) { should eq 'python2.7' }
  its(:handler) { should eq 'lambda_function.lambda_handler' }
  its(:code_size) { should eq 9_625_719 }
  its(:timeout) { should eq 20 }
  its(:memory_size) { should eq 256 }
  its(:role) { should eq 'arn:aws:iam::123456789000:role/lambda_role' }

  its(:environment) { should include 'key_a' => 'value_a', 'key_b' => 'value_b' }
end

describe lambda('not-exist-function') do
  it { should_not exist }
end
