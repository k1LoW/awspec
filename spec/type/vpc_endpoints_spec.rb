require 'spec_helper'
Awspec::Stub.load 'vpc_endpoints'

describe vpc_endpoints('vpce-abc123') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('vpc-12345678') }
  it { should have_route_table('rtb-0123456789abcdefg') }
  its(:vpc_endpoint_type) { should eq 'Gateway' }
end

describe vpc_endpoints('vpce-123456789abcdefgh') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('vpc-abc123') }
  it { should have_subnet('subnet-abc123') }
  its(:vpc_endpoint_type) { should eq 'Interface' }
end
