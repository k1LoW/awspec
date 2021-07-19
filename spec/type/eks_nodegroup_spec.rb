require 'spec_helper'
Awspec::Stub.load 'eks_nodegroup'

describe eks_nodegroup('my-eks-nodegroup'), cluster: 'my-cluster' do
  it { should exist }
  its(:version) { should eq '1.17' }
  it { should be_active }
  its(:nodegroup_arn) { should eq 'arn:aws:eks:us-west-2:012345678910:nodegroup/my-cluster/my-nodegroup/08bd000a' }
  its(:node_role) { should eq 'arn:aws:iam::012345678910:role/eks-nodegroup-role' }
end
