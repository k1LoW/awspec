require 'spec_helper'
Awspec::Stub.load 'batch_job_definition'

describe batch_job_definition('my-batch-job-definition') do
  it { should exist }
end
