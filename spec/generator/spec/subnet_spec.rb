require 'spec_helper'

describe 'Awspec::Generator::Spec::Subnet' do
  before do
    Awspec::Stub.load 'subnet'
  end
  let(:subnet) { Awspec::Generator::Spec::Subnet.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe subnet('my-subnet') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc('my-vpc') }
  its(:subnet_id) { should eq 'subnet-1234a567' }
  its(:cidr_block) { should eq '10.0.1.0/24' }
end
EOF
    expect(subnet.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
