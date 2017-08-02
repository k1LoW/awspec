require 'spec_helper'
Awspec::Stub.load 'alb_target_group'

describe alb_target_group('my-alb-target-group') do
  it { should exist }
  its(:health_check_path) { should eq '/' }
  its(:health_check_port) { should eq 'traffic-port' }
  its(:health_check_protocol) { should eq 'HTTP' }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_alb('my-alb') }
  it { should have_ec2('my-ec2') }
end
