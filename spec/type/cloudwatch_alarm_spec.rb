# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'cloudwatch_alarm'

describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should exist }
  it { should have_ok_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
  it { should have_alarm_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
  it { should have_insufficient_data_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
  it { should belong_to_metric('NumberOfProcesses') }
  it { should belong_to_metric('NumberOfProcesses').namespace('my-cloudwatch-namespace') }
  its(:state_value) { should eq 'OK' }
end
