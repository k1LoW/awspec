require 'spec_helper'

Awspec::Stub.load 'ecs_cluster'

describe ecs_cluster('my-ecs-cluster') do
  it { should exist }
  it { should be_active }
  it { should_not be_inactive }
  its(:cluster_name) { should eq 'my-ecs-cluster' }
  its(:cluster_arn) { should eq 'arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster' }
  its(:registered_container_instances_count) { should eq 2 }
  its(:running_tasks_count) { should eq 0 }
  its(:pending_tasks_count) { should eq 0 }
  its(:active_services_count) { should eq 0 }
  it { have_container_instance('f2756532-8f13-4d53-87c9-aed50dc94cd7') }
end
