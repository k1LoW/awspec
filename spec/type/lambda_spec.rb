require 'spec_helper'
Awspec::Stub.load 'lambda'

describe lambda('my-lambda-function-name') do
  it { should exist }
  its(:description) { should eq 'My Lambda Function' }
  its(:runtime) { should eq 'python2.7' }
  its(:handler) { should eq 'lambda_function.lambda_handler' }
  its(:code_size) { should eq 1234 }
  its(:timeout) { should eq 5 }
  its(:memory_size) { should eq 256 }
end

describe lambda('not-exist-function') do
  it { should_not exist }
end
