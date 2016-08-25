require 'spec_helper'
Awspec::Stub.load 'cloudwatch_event'

describe cloudwatch_event('my-cloudwatch-event') do
  it { should exist }
  it { should be_enable }
  it { should be_scheduled('cron(* * * * * *)') }
end
