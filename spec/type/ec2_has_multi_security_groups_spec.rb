require 'spec_helper'
Awspec::Stub.load 'ec2_has_multi_security_groups'

describe ec2('i-ec12345a') do
  it { should have_security_groups(['sg-1a2b3cd4', 'sg-5e6f7gh8']) }
  it { should have_security_groups(['my-security-group-name', 'my-security-group-name-2']) }
  it { should have_security_groups(['my-security-group-tag-name', 'my-security-group-tag-name-2']) }
end
