require 'spec_helper'
require 'stub/elb'

describe elb('my-elb') do
  it { should exist }
  it { should have_ec2('my-ec2') }
  it { should have_security_group('my-lb-security-group-tag-name') }
  it { should have_subnet('my-subnet') }
end
