require 'spec_helper'
Awspec::Stub.load 'ec2_running'

describe ec2_running('my-ec2-running') do
  it { should exist }
end
