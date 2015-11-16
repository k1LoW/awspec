require 'spec_helper'

describe 'Awspec::Generator::Spec::RouteTable' do
  before do
    Awspec::Stub.load 'route_table'
  end
  let(:route_table) { Awspec::Generator::Spec::RouteTable.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe route_table('my-route-table') do
  it { should exist }
  it { should belong_to_vpc('my-vpc') }
  it { should have_route('10.0.0.0/16').target(geteway: 'local') }
  it { should have_route('0.0.0.0/0').target(geteway: 'igw-1ab2345c') }
  it { should have_route('192.168.1.0/16').target(instance: 'my-ec2') }
end
EOF
    expect(route_table.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
