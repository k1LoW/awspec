require 'spec_helper'
Awspec::Stub.load 'batch_compute_environment'

describe batch_compute_environment('my-batch-compute-environment') do
  it { should exist }
end
