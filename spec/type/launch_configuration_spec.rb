require 'spec_helper'
Awspec::Stub.load 'launch_configuration'

describe launch_configuration('my-lc') do
  it { should exist }
  it { should have_security_group('my-security-group-name') }
  its(:associate_public_ip_address) { should eq true }
end
