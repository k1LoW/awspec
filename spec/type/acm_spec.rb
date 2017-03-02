require 'spec_helper'
Awspec::Stub.load 'acm'

describe acm('example.com') do
  it { should exist }
  it { should be_issued }
  its(:type) { should eq 'AMAZON_ISSUED' }
end
