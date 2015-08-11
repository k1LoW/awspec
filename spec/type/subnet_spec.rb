require 'spec_helper'
require 'stub/subnet'

describe subnet('my-subnet') do
  it { should exist }
  it { should be_available }
  its(:subnet_id) { should eq 'subnet-1234a567' }
  its(:cidr_block) { should eq '10.0.1.0/24' }
  it { should belong_to_vpc('my-vpc') }
end
