require 'spec_helper'
Awspec::Stub.load 'apigateway'

describe apigateway('my-apigateway') do
  it { should exist }
end
