require 'spec_helper'
require 'awspec/error'
Awspec::Stub.load 'lambda'

describe lambda('my-lambda-function-name') do
  it { should exist }
  its(:description) { should eq 'My Lambda Function' }
  its(:runtime) { should eq 'python2.7' }
  its(:handler) { should eq 'lambda_function.lambda_handler' }
  its(:code_size) { should eq 1234 }
  its(:timeout) { should eq 5 }
  its(:memory_size) { should eq 256 }
  its(:last_modified) { should eq Time.new(2018, 12, 05, 19, 10, 44, '+00:00') }
  its(:code_sha_256) { should eq 'LAI9GRLpJD/dq2D7Uopwaeh354tsd8fQsSI6eSH0xOIs=' }
  its(:version) { should eq '$LATEST' }
  its(:role) { should eq 'arn:aws:iam::123456789:role/foobarVPCRole' }
  its(:kms_key_arn) { should be nil }
  its(:revision_id) { should eq '8d01897515-bcb0-43c7-9b14-e6d14fyyff4d' }
  its(:layers) { should be nil }
end

describe lambda('not-exist-function') do
  it { should_not exist }
  methods = %w(description runtime handler code_size timeout memory_size last_modified code_sha_256 version RESOLVER1 kms_key_arn revision_id layers)
  methods.each do |method_name|
    it "#{method_name} raises Awspec::NoExistingResource" do
      expect { subject.send(method_name) }.to raise_error(Awspec::NoExistingResource)
    end
  end
end
