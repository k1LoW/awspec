# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::NatGateway' do
  before do
    Awspec::Stub.load 'nat_gateway'
  end
  let(:nat_gateway) { Awspec::Generator::Spec::NatGateway.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe nat_gateway('nat-7ff7777f') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('my-vpc') }
  it { should have_eip('123.0.456.789') }
end
EOF
    expect(nat_gateway.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
