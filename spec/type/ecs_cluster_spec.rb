require 'spec_helper'

Awspec::Stub.load 'ecs'

describe ecs_cluster('my-ecs-cluster') do
  it { should exist }
  its(:cluster_name) { should eq 'my-ecs-cluster' }
  its(:cluster_arn) { should eq "arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster" }
  its(:registered_container_instances_count) { should eq 0 }
  its(:running_tasks_count) { should eq 0 }
  its(:pending_tasks_count) { should eq 0 }
  its(:active_services_count) { should eq 0 }
end
