require 'spec_helper'
Awspec::Stub.load 'internet_gateway'

describe internet_gateway('igw-1ab2cd3e') do
  it { should exist }
  it { should have_tag('Name').value('my-internet-gateway') }
  it { should be_attached_to('vpc-ab123cde') }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
  end
end

describe internet_gateway('my-internet-gateway') do
  it { should exist }
end
