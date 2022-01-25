# frozen_string_literal: true

require 'spec_helper'
require 'awspec/error'
Awspec::Stub.load 'lambda'

EXPECTED = {
  'ENDPOINT_URL' => 'https://foobar.sns.us-east-1.vpce.amazonaws.com',
  'ENV_NAME' => 'QA',
  'FOOBAR_TOPIC' => 'arn:aws:sns:us-east-1:123456789:FoobarManager',
  'LOG_LEVEL' => 'DEBUG',
  'RESOLVER1' => '10.196.138.1',
  'RESOLVER2' => '10.196.136.2'
}

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
  its(:kms_key_arn) { should be_nil }
  its(:revision_id) { should eq '8d01897515-bcb0-43c7-9b14-e6d14fyyff4d' }
  its(:layers) { should be nil }
  its(:tracing_config) { should have_attributes('mode' => 'PassThrough') }
  it { should have_env_vars }

  EXPECTED.each_pair do |key, value|
    context "environment variable #{key}" do
      it { should have_env_var(key) }
      it { should have_env_var_value(key, value) }
    end
  end
end

describe lambda('no-existing-function') do
  it { should_not exist }
  methods = %w[environment description runtime handler code_size timeout memory_size last_modified code_sha_256 version
               kms_key_arn revision_id layers tracing_config]
  methods.each do |method_name|
    it "#{method_name} raises Awspec::NoExistingResource" do
      expect { subject.send(method_name) }.to raise_error(Awspec::NoExistingResource)
    end
  end
end
