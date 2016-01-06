require 'spec_helper'
Awspec::Stub.load 'ami'

describe ami('my-ami') do
  it { should exist }
  it { should be_available }
  its(:architecture) { should eq 'x86_64' }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its(:data) { should be_an_instance_of(Aws::EC2::Types::Image) }
  end
end
