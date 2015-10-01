require 'spec_helper'
Awspec::Stub.load 'ses_identity'

describe ses_identity('my-ses-identity') do
  it { should exist }
end
