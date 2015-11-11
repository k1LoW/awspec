require 'spec_helper'

describe 'Awspec::Generator::Spec::NetworkAcl' do
  before do
    Awspec::Stub.load 'network_acl'
  end
  let(:network_acl) { Awspec::Generator::Spec::NetworkAcl.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe network_acl('my-network-acl') do
  it { should exist }
  it { should belong_to_vpc('my-vpc') }
  it { should have_subnet('my-subnet') }
  its(:outbound) { should be_allowed.protocol('ALL').source('0.0.0.0/0').rule_number(100) }
  its(:outbound) { should be_denied.protocol('ALL').source('0.0.0.0/0').rule_number('*') }
  its(:inbound) { should be_allowed(80).protocol('TCP').source('123.0.456.789/32').rule_number(2) }
  its(:inbound) { should be_allowed.protocol('ALL').source('0.0.0.0/0').rule_number(100) }
  its(:inbound) { should be_denied.protocol('ALL').source('0.0.0.0/0').rule_number('*') }
  its(:inbound_entries_count) { should eq 3 }
  its(:outbound_entries_count) { should eq 3 }
end
EOF
    expect(network_acl.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
