# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'launch_template'

describe launch_template('my-launch-template') do
  it { should exist }
  its(:default_version_number) { should eq 1 }
  its(:latest_version_number) { should eq 2 }
end
