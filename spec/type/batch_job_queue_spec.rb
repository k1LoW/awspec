require 'spec_helper'
Awspec::Stub.load 'batch_job_queue'

describe batch_job_queue('my-batch-job-queue') do
  it { should exist }
end
