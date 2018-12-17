require 'spec_helper'
Awspec::Stub.load 'launch_template'

describe launch_template('my-launch-template') do
  it { should exist }
end
