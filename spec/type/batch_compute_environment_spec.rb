# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'batch_compute_environment'

describe batch_compute_environment('my-batch-compute-environment') do
  it { should exist }
  it { should be_enabled }
  it { should_not be_disabled }
  it { should be_managed }
  it { should_not be_unmanaged }
  its(:compute_environment_arn) { should eq 'arn:aws:batch:us-east-1:012345678910:compute-environment/P2OnDemand' }
  its(:compute_environment_name) { should eq 'P2OnDemand' }
  its('compute_resources.type') { should eq 'EC2' }
  its('compute_resources.desiredv_cpus') { should eq 48 }
  its('compute_resources.ec2_key_pair') { should eq 'id_rsa' }
  its('compute_resources.instance_role') { should eq 'ecsInstanceRole' }
  its('compute_resources.instance_types.count') { should eq 1 }
  its('compute_resources.instance_types') { should include 'p2' }
  its('compute_resources.maxv_cpus') { should eq 128 }
  its('compute_resources.minv_cpus') { should eq 0 }
  its('compute_resources.security_group_ids.count') { should eq 1 }
  its('compute_resources.security_group_ids') { should include 'sg-cf5093b2' }
  its('compute_resources.subnets.count') { should eq 3 }
  its('compute_resources.subnets') { should include 'subnet-220c0e0a' }
  its('compute_resources.subnets') { should include 'subnet-1a95556d' }
  its('compute_resources.subnets') { should include 'subnet-978f6dce' }
  its('compute_resources.tags') { should include('name' => 'Batch Instance - P2OnDemand') }
  its(:ecs_cluster_arn) do
    should eq 'arn:aws:ecs:us-east-1:012345678910:cluster/P2OnDemand_Batch_2c06f29d-d1fe-3a49-879d'
  end
  its(:service_role) { should eq 'arn:aws:iam::012345678910:role/AWSBatchServiceRole' }
  its(:status) { should eq 'VALID' }
  its(:status_reason) { should eq 'ComputeEnvironment Healthy' }
end
