# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Redshift' do
  before do
    Awspec::Stub.load 'redshift'
  end
  let(:redshift) { Awspec::Generator::Spec::Redshift.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe redshift('my-redshift') do
  it { should exist }
  it { should be_available }
  its(:node_type) { should eq 't2.medium' }
  its(:db_name) { should eq 'my-db' }
  its(:availability_zone) { should eq 'ap-northeast-1a' }
  it { should have_security_group('group-name-sg') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_cluster_subnet_group('my-sg') }
  it { should have_cluster_parameter_group('my-pg').parameter_apply_status('in-sync') }
  it { should have_tag('Name').value('my-cluster') }
end
EOF
    expect(redshift.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
