require 'spec_helper'
Awspec::Stub.load 'cognito_user_pool'

describe cognito_user_pool('my-cognito-user-pool') do
  it { should exist }
end
