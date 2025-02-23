# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Wafv2IpSet' do
  before do
    Awspec::Stub.load 'wafv2_ip_set'
  end
  let(:wafv2_ip_set) { Awspec::Generator::Spec::Wafv2IpSet.new }
  it 'generate_by_scope generate spec' do
    spec = <<-'EOF'
describe wafv2_ip_set('my-wafv2-ip-set'), scope: 'REGIONAL' do
  it { should exist }
  its(:name) { should eq 'my-wafv2-ip-set' }
  its(:id) { should eq '01234567-89ab-cdef-0123-456789abcdef' }
  its(:arn) { should eq 'arn:aws:wafv2:ap-northeast-1:123456789012:regional/ipset/my-wafv2-ip-set/01234567-89ab-cdef-0123-456789abcdef' }
  its(:description) { should eq 'dev ips' }
  its(:ip_address_version) { should eq 'IPV4' }
  it { should have_ip_address('10.0.0.0/32') }
  it { should have_ip_address('10.0.0.1/32') }
end
EOF
    expect(wafv2_ip_set.generate_by_scope('REGIONAL').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
