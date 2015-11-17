require 'spec_helper'
Awspec::Stub.load 'subnet'

describe subnet('my-subnet') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('my-vpc') }
  its(:subnet_id) { should eq 'subnet-1234a567' }
  its(:cidr_block) { should eq '10.0.1.0/24' }
end
