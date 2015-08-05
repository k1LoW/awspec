require 'spec_helper'

describe 'Awspec::Generator::Spec::Vpc' do
  before do
    require 'stub/vpc'
  end
  let(:vpc) { Awspec::Generator::Spec::Vpc.new }
  it 'generate_from_vpc generate spec' do
    spec = <<-'EOF'
describe vpc('my-vpc') do
  it { should exist }
  it { should be_available }
  its(:vpc_id) { should eq 'vpc-ab123cde' }
  its(:cidr_block) { should eq '10.0.0.0/16' }
  it { should have_route_table('my-route-table') }
  it { should have_network_acl('my-network-acl') }
end
EOF
    expect(vpc.generate_from_vpc('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
