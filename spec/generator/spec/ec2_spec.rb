require 'spec_helper'

describe 'Awspec::Generator::Spec::Ec2' do
  before do
    Awspec::Stub.load 'ec2'
  end
  let(:ec2) { Awspec::Generator::Spec::Ec2.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe ec2('my-ec2') do
  it { should exist }
  it { should be_running }
  its(:instance_id) { should eq 'i-ec12345a' }
  its(:image_id) { should eq 'ami-abc12def' }
  its(:instance_type) { should eq 't2.small' }
  its(:private_ip_address) { should eq '10.0.1.1' }
  its(:public_ip_address) { should eq '123.0.456.789' }
  it { should have_security_group('my-security-group-name') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('my-subnet') }
  it { should have_eip('123.0.456.789') }
  it { should have_ebs('my-volume') }
end
EOF
    expect(ec2.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
