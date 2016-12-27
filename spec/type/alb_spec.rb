require 'spec_helper'
Awspec::Stub.load 'alb'

describe alb('my-alb') do
  it { should exist }
end
