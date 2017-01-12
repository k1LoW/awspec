require 'spec_helper'
Awspec::Stub.load 'autoscaling_group'

describe autoscaling_group('my-auto-scaling-group') do
  it { should exist }
  its(:desired_capacity) { should eq 4 }
  its(:min_size) { should eq 4 }
  its(:max_size) { should eq 20 }
  its(:default_cooldown) { should eq 300 }
  its(:launch_configuration_name) { should eq 'my-lc' }
  its(:health_check_type) { should eq 'EC2' }
  it { should have_ec2('my-ec2') }
  it { should have_elb('my-elb') }
  it { should have_tag('name').value('my-autoscaling-group') }
end

# deprecated
describe auto_scaling_group('my-auto-scaling-group') do
  it { should exist }
  its(:desired_capacity) { should eq 4 }
  its(:min_size) { should eq 4 }
  its(:max_size) { should eq 20 }
  its(:default_cooldown) { should eq 300 }
  its(:launch_configuration_name) { should eq 'my-lc' }
  its(:health_check_type) { should eq 'EC2' }
  it { should have_ec2('my-ec2') }
  it { should have_elb('my-elb') }
  it { should have_tag('name').value('my-autoscaling-group') }
end
