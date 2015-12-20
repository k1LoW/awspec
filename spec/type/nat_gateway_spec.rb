require 'spec_helper'
Awspec::Stub.load 'nat_gateway'

describe nat_gateway('my-nat-gateway') do
  it { should exist }
end
