require 'spec_helper'
Awspec::Stub.load 'cognito_identity_pool'

describe cognito_identity_pool('my-cognito-identity-pool') do
  it { should exist }
end
