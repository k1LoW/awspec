require 'spec_helper'

Awspec::Stub.load 'ecs_service'

describe ecs_service('my-ecs-service') do
  it { should exist }
  it { should be_active }
  it { should_not be_inactive }
  it { should_not be_draining }
  its(:status) { should eq 'ACTIVE' }
  its(:service_name) { should eq 'my-ecs-service' }
  its(:cluster_arn) { should eq 'arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster' }
  its(:task_definition) { should eq 'arn:aws:ecs:us-east-1:123456789012:task-definition/my-ecs-task-definition:8' }
  its(:desired_count) { should eq 1 }
  its(:pending_count) { should eq 0 }
  its(:running_count) { should eq 0 }
end
