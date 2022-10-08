# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::CloudwatchEvent' do
  before do
    Awspec::Stub.load 'cloudwatch_event'
  end
  let(:cloudwatch_event) { Awspec::Generator::Spec::CloudwatchEvent.new }
  it 'generate_all generate spec' do
    spec = <<-'EOF'

describe cloudwatch_event('my-cloudwatch-event') do
  it { should exist }
  it { should be_enable }
  it { should be_scheduled('cron(* * * * * *)') }
end
EOF
    expect(cloudwatch_event.generate_all.to_s.gsub(/\n/, "\n")).to eq spec
  end
end
