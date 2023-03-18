# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::RdsGlobalCluster' do
  before do
    Awspec::Stub.load 'rds_global_cluster'
  end
  let(:rds_global_cluster) { Awspec::Generator::Spec::RdsGlobalCluster.new }
  it 'generate spec' do
    spec = <<-'EOF'
describe rds_global_cluster('my-rds-global-cluster') do
  it { should exist }
  it { should be_available }
  it { should have_cluster_member('arn:aws:rds:ap-northeast-1:123456789012:cluster:my-primary-cluster').is_writer(true) }
  it { should have_cluster_member('arn:aws:rds:ap-northeast-3:123456789012:cluster:my-secondary-cluster').is_writer(false) }
  its(:engine) { should eq 'aurora-mysql' }
  its(:engine_version) { should eq '5.7.mysql_aurora.2.10.2' }
  its(:database_name) { should eq 'example_db' }
  its(:storage_encrypted) { should eq false }
  its(:deletion_protection) { should eq false }
end
EOF
    expect(rds_global_cluster.generate('my-rds-global-cluster').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
