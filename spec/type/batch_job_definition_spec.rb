require 'spec_helper'
Awspec::Stub.load 'batch_job_definition'

describe batch_job_definition('my-batch-job-definition') do
  it { should exist }
  its(:type) { should eq 'container' }
  its('container_properties.command') { should eq %w[sleep 60] }
  its('container_properties.environment') { should be_empty }
  its('container_properties.image') { should eq 'busybox' }
  its('container_properties.memory') { should eq 128 }
  its('container_properties.mount_points') { should be_empty }
  its('container_properties.ulimits') { should be_empty }
  its('container_properties.vcpus') { should eq 1 }
  its('container_properties.volumes') { should be_empty }
  its(:job_definition_arn) { should eq 'arn:aws:batch:us-east-1:012345678910:job-definition/sleep60:1' }
  its(:job_definition_name) { should eq 'sleep60' }
  its(:revision) { should eq 1 }
  its(:status) { should eq 'ACTIVE' }
end
