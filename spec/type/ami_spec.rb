require 'spec_helper'
Awspec::Stub.load 'ami'

describe ami('my-ami') do
  it { should exist }
end
