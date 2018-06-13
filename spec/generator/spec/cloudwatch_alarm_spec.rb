require 'spec_helper'

describe 'Awspec::Generator::Spec::CloudwatchAlarm' do
  before do
    Awspec::Stub.load 'cloudwatch_alarm'
  end
  let(:cloudwatch_alarm) { Awspec::Generator::Spec::CloudwatchAlarm.new }
  it 'generate_all generate spec' do
    spec = <<-'EOF'

describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should exist }
  it { should have_ok_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
  it { should have_alarm_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
  it { should have_insufficient_data_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
  it { should belong_to_metric('NumberOfProcesses').namespace('my-cloudwatch-namespace') }
  its(:state_value) { should eq 'OK' }
  its(:statistic) { should eq 'Average' }
  its(:period) { should eq 300 }
  its(:unit) { should eq 'Seconds' }
  its(:evaluation_periods)  { should eq 1 }
  its(:datapoints_to_alarm)  { should eq 1 }
  its(:threshold)  { should eq 5.0 }
  its(:comparison_operator)  { should eq 'LessThanOrEqualToThreshold' }
end
EOF
    expect(cloudwatch_alarm.generate_all.to_s.gsub(/\n/, "\n")).to eq spec
  end
end
