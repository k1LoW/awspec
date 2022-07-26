# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::RdsProxy' do
  before do
    Awspec::Stub.load 'rds_proxy'
  end
  let(:rds_proxy) { Awspec::Generator::Spec::RdsProxy.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe rds_proxy('my-rds-proxy') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should have_security_group('sg-5a6b7cd8') }
  it { should belong_to_subnet('subnet-8901b123') }
end
EOF
    expect(rds_proxy.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
