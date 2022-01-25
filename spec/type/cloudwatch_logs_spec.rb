# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'cloudwatch_logs'

describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should exist }
  its(:retention_in_days) { should eq 365 }
  it { should have_log_stream('my-cloudwatch-logs-stream') }
  it { should have_metric_filter('my-cloudwatch-logs-metric-filter') }
  it do
    should have_metric_filter('my-cloudwatch-logs-metric-filter')\
      .filter_pattern('[date, error]')
  end
  it { should have_subscription_filter('my-cloudwatch-logs-subscription-filter') }
  it do
    should have_subscription_filter('my-cloudwatch-logs-subscription-filter')\
      .filter_pattern('[host, ident, authuser, date, request, status, bytes]')
  end
  it { should have_tag('key_one').value('value_one') }
end
