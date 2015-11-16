require 'spec_helper'
Awspec::Stub.load 'route_table'

describe route_table('my-route-table') do
  it { should exist }
  it { should belong_to_vpc('my-vpc') }
  its(:route_table_id) { should eq 'rtb-a12bcd34' }
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_route('0.0.0.0/0').target(gateway: 'my-igw') }
  it { should have_route('192.168.1.0/24').target(instance: 'my-ec2') }
end

# deprecated
describe route_table('my-route-table') do
  it { should have_route('local').destination('10.0.0.0/16') }
  it { should have_route('my-igw').destination('0.0.0.0/0') }
end
