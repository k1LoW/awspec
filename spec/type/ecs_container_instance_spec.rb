require 'spec_helper'

Awspec::Stub.load 'ecs_container_instance'

describe ecs_container_instance('my-container-instance') do
  it { should exist }
  it { should be_active }
  it { should_not be_inactive }
  its(:status) { should eq 'ACTIVE' }
  its(:container_instance_arn) do
    should eq 'arn:aws:ecs:us-east-1:123456789012:container-instance'\
              '/f2756532-8f13-4d53-87c9-aed50dc94cd7'
  end
end
