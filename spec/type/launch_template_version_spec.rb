require 'spec_helper'
Awspec::Stub.load 'launch_template_version'

describe launch_template_version('lt-01238c059e3466abc') do
  it { should exist }
end
