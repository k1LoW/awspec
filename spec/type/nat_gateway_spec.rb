require 'spec_helper'
Awspec::Stub.load 'nat_gateway'

describe nat_gateway('nat-7ff7777f') do
  it { should exist }
  it { should be_available }
  it { should have_eip('123.0.456.789') }
  it { should belong_to_vpc('my-vpc') }
end
