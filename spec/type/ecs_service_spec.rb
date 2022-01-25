# frozen_string_literal: true

require 'spec_helper'

Awspec::Stub.load 'ecs_service'

describe ecs_service('my-ecs-service') do
  it { should exist }
  it { should be_active }
  it { should_not be_inactive }
  it { should_not be_draining }
  its(:cluster) { should eq 'default' }
  its(:service_name) { should eq 'my-ecs-service' }
  its(:cluster_arn) { should eq 'arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster' }
  its(:task_definition) { should eq 'arn:aws:ecs:us-east-1:123456789012:task-definition/my-ecs-task-definition:8' }
  its(:desired_count) { should eq 1 }
  its(:pending_count) { should eq 0 }
  its(:running_count) { should eq 0 }
end

describe ecs_service('my-ecs-service'), cluster: 'my-ecs-cluster' do
  it { should exist }
  its(:cluster) { should eq 'my-ecs-cluster' }
end

describe 'ESC Cluster `my-ecs-cluster`' do
  before do |example|
    example.metadata[:described_class].cluster = 'my-ecs-cluster'
  end
  describe ecs_service('my-ecs-service') do
    it { should exist }
    its(:cluster) { should eq 'my-ecs-cluster' }
  end
end
