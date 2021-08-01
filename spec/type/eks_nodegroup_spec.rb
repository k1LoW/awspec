require 'spec_helper'
Awspec::Stub.load 'eks_nodegroup'

describe eks_nodegroup('my-eks-nodegroup'), cluster: 'my-cluster' do
  it { should exist }
  its(:version) { should eq '1.17' }
  it { should be_active }
  it { should be_ready }
  its(:nodegroup_arn) { should eq 'arn:aws:eks:us-west-2:012345678910:nodegroup/my-cluster/my-nodegroup/08bd000a' }
  its(:node_role) { should eq 'arn:aws:iam::012345678910:role/eks-nodegroup-role' }
  its('scaling_config.min_size') { should eq 1 }
  its('scaling_config.desired_size') { should eq 2 }
  its('scaling_config.max_size') { should eq 3 }
  it { should belong_to_subnets('subnet-1234a567') }
  it { should_not belong_to_subnets('subnet-1234a567YYY', 'subnet-1234a567ZZZ') }
  it { should have_security_group('sg-1a2b3cd4') }
  it { should have_security_group('my-security-group-name') }
  it { should_not have_security_group('sg-zyx') }
  it { should_not have_security_group('my-other-security-group-name') }
end
