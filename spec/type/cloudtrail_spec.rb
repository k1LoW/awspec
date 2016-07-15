require 'spec_helper'
Awspec::Stub.load 'cloudtrail'

describe cloudtrail('my-trail') do
  it { should exist }
  it { should have_global_service_events_included }
  it { should be_multi_region_trail }
  it { should have_log_file_validation_enabled }
end
