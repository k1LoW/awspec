require 'spec_helper'
Awspec::Stub.load 'lambda'

describe lambda('my-lambda-function-name') do
  it { should exist }
  its(:function_name) { should eq 'my-lambda-function-name' }
  its(:runtime) { should eq 'nodejs' }
  its(:timeout) { should eq 5 }
  its(:memory_size) { should eq 256 }
end

describe lambda('not-exist-function') do
  it { should_not exist }
end
