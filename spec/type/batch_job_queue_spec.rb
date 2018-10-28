require 'spec_helper'
Awspec::Stub.load 'batch_job_queue'

describe batch_job_queue('my-batch-job-queue') do
  it { should exist }
  it { should be_enabled }
  it { should_not be_disabled }
  its('compute_environment_order.count') { should eq 1 }
  it { should have_compute_environment_order('arn:aws:batch:us-east-1:012345678910:compute-environment/C4OnDemand', 1) }
  its(:job_queue_arn) { should eq 'arn:aws:batch:us-east-1:012345678910:job-queue/HighPriority' }
  its(:job_queue_name) { should eq 'HighPriority' }
  its(:priority) { should eq 1 }
  its(:status) { should eq 'VALID' }
  its(:status_reason) { should eq 'JobQueue Healthy' }
end
