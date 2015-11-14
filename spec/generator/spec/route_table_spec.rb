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
  it { shold have_route('local').destination('10.0.0.0/16') }
  it { shold have_route('igw-1ab2345c').destination('0.0.0.0/0') }
end
EOF
    expect(route_table.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
