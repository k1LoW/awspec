# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::ManagedPrefixList' do
  before do
    Awspec::Stub.load 'managed_prefix_list'
  end
  let(:managed_prefix_list) { Awspec::Generator::Spec::ManagedPrefixList.new }
  it 'generate spec' do
    spec = <<-'EOF'
describe managed_prefix_list('my-managed-prefix-list') do
  it { should exist }
  it { should have_cidr('10.0.0.0/16').desc('test') }
  it { should have_cidr('192.168.0.0/24').desc('dev') }
  its(:entries_count) { should eq 2 }
  its(:prefix_list_id) { should eq 'pl-12345678' }
  its(:address_family) { should eq 'IPv4' }
  its(:state) { should eq 'create-complete' }
  its(:prefix_list_arn) { should eq 'arn:aws:ec2:ap-northeast-1:aws:prefix-list/pl-12345678' }
  its(:max_entries) { should eq 2 }
  its(:version) { should eq 1 }
  its(:owner_id) { should eq '123456789012' }
  it { should have_tag('env').value('dev') }
end
EOF
    expect(managed_prefix_list.generate_all.to_s.gsub(/\n/, "\n")).to eq spec
  end
end
