# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'launch_configuration'

describe launch_configuration('my-lc') do
  it { should exist }
  it { should have_security_group('my-security-group-name') }
  its(:associate_public_ip_address) { should eq true }
  it { should have_block_device_mapping('/dev/sdf') }
  it { should have_block_device_mapping('ephemeral0') }
end
