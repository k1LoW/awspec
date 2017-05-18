require 'spec_helper'
Awspec::Stub.load 'subnet'

describe subnet('my-subnet') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('my-vpc') }
  its(:subnet_id) { should eq 'subnet-1234a567' }
  its(:cidr_block) { should eq '10.0.1.0/24' }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('vpc.id') { should eq 'vpc-ab123cde' }
  end
  it { should have_tag('Name').value('my-subnet') }
end
