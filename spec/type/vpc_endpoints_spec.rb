require 'spec_helper'
Awspec::Stub.load 'vpc_endpoints'
describe vpc_endpoints('my-vpcendpoint') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('vpc-abc123') }
  it { should have_subnet('my-subnet') }
  it { should have_route_table('my-subnet') }
end
