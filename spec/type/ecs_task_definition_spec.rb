require 'spec_helper'

Awspec::Stub.load 'ecs_task_definition'

describe ecs_task_definition('my-ecs-task-definition') do
  it { should exist }
  it { should be_active }
  it { should_not be_inactive }
  its(:status) { should eq 'ACTIVE' }
  its(:family) { should eq 'my-ecs-task-definition' }
  its(:revision) { should eq 8 }
  its(:task_definition_arn) { should eq 'arn:aws:ecs:us-east-1:123456789012:task-definition/my-ecs-task-definition:8' }
  its(:task_role_arn) { should eq 'arn:aws:iam::123456789012:role/my-iam-role' }
end
