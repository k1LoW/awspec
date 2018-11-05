require 'spec_helper'
Awspec::Stub.load 'sns'

describe sns('my-sns') do
  it { should exist }
end
