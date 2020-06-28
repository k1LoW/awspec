require 'spec_helper'
Awspec::Stub.load 'msk'

describe msk('my-msk') do
  it { should exist }
  it { should be_active }
end
