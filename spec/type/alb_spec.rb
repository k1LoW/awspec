require 'spec_helper'
Awspec::Stub.load 'alb'

describe alb('my-alb') do
  it { should exist }
  it { should be_active }
  its(:dns_name) { should eq 'internal-my-elb-1551266724.ap-northeast-1.elb.amazonaws.com' }
  it { should have_security_group('sg-1a2b3cd4') }
  it { should have_security_group('my-security-group-name') }
  it { should have_subnet('subnet-1234a567') }
  it { should have_subnet('my-subnet') }
  it { should belong_to_vpc('my-vpc') }
  it { should have_tag('environment').value('dev') }
end
