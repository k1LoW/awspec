# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'nlb'

describe nlb('my-nlb') do
  it { should exist }
  it { should be_active }
  its(:dns_name) { should eq 'internal-my-nlb-1551266724.ap-northeast-1.elb.amazonaws.com' }
  it { should have_subnet('subnet-1234a567') }
  it { should have_subnet('my-subnet') }
  it { should belong_to_vpc('my-vpc') }
end
