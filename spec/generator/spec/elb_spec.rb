# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Elb' do
  before do
    Awspec::Stub.load 'elb'
  end
  let(:elb) { Awspec::Generator::Spec::Elb.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe elb('my-elb') do
  it { should exist }
  its(:load_balancer_name) { should eq 'my-elb' }
  its(:health_check_target) { should eq 'HTTP:80/index.php' }
  its(:health_check_interval) { should eq 60 }
  its(:health_check_timeout) { should eq 5 }
  its(:health_check_unhealthy_threshold) { should eq 10 }
  its(:health_check_healthy_threshold) { should eq 2 }
  it { should have_listener(protocol: 'HTTPS', port: 443, instance_protocol: 'HTTP', instance_port: 80) }
  it { should have_tag('Name').value('my-elb') }
  it { should have_tag('my-tag-key').value('my-tag-value') }
end
EOF
    expect(elb.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
