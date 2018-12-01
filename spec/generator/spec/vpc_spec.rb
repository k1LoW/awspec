require 'spec_helper'

describe 'Awspec::Generator::Spec::Vpc' do
  before do
    Awspec::Stub.load 'vpc'
  end
  let(:vpc) { Awspec::Generator::Spec::Vpc.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe vpc('my-vpc') do
  it { should exist }
  it { should be_available }
  its(:vpc_id) { should eq 'vpc-ab123cde' }
  its(:cidr_block) { should eq '10.0.0.0/16' }
  it { should have_route_table('my-route-table') }
  it { should have_network_acl('my-network-acl') }
  it { should have_vpc_attribute('enableDnsHostnames') }
  it { should_not have_vpc_attribute('enableDnsSupport') }
end
EOF
    expect(vpc.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
