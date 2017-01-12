require 'spec_helper'
Awspec::Stub.load 'alb'

describe alb('my-alb') do
  it { should exist }
end

describe alb('my-alb') do
  its(:dns_name) { should eq 'my-load-balancer-123456789.us-west-1.elb.amazonaws.com' }
end
