# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'eks'

describe eks('my-eks') do
  it { should exist }
  it { should be_active }
  its(:role_arn) { should eq('arn:aws:iam::012345678910:role/eks-service-role') }
  its('resources_vpc_config.security_group_ids') { should eq(['sg-6979fe18']) }
  its('resources_vpc_config.vpc_id') { should eq('vpc-950809ec') }
end
