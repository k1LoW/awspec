require 'spec_helper'
Awspec::Stub.load 'route_table'

describe route_table('my-route-table') do
  it { should exist }
  its(:route_table_id) { should eq 'rtb-a12bcd34' }
  it { should have_route('local').destination('10.0.0.0/16') }
  it { should have_route('my-igw').destination('0.0.0.0/0') }
end
