require 'spec_helper'
Awspec::Stub.load 'eks_nodegroup'

describe eks_nodegroup('my-eks-nodegroup'), cluster: 'my-cluster' do
  it { should exist }
  its(:version) { should eq '1.17' }
  it { should be_active }
end
