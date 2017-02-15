require 'spec_helper'

describe 'Awspec::Generator::Spec::NetworkInterface' do
  before do
    Awspec::Stub.load 'network_interface'
  end
  let(:network_interface) { Awspec::Generator::Spec::NetworkInterface.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe network_interface('eni-12ab3cde') do
  it { should exist }
  it { should be_in_use }
  it { should be_attached_to('my-ec2').as_eth1 }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('my-subnet') }
  it { should have_private_ip_address('10.0.1.1').primary }
  it { should have_private_ip_address('10.0.1.2') }
  its(:private_ip_addresses_count) { should eq 2 }
end
EOF
    expect(network_interface.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
