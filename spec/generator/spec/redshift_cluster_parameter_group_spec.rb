require 'spec_helper'

describe 'Awspec::Generator::Spec::Redshift' do
  before do
    Awspec::Stub.load 'redshift_cluster_parameter_group'
  end
  let(:redshift_cluster_parameter_group) { Awspec::Generator::Spec::RedshiftClusterParameterGroup.new }
  it 'generate_by_cluster_parameter_group generate spec' do
    spec = <<-'EOF'
describe redshift_cluster_parameter_group('my-redshift-cluster-parameter-group') do
  its('datestyle') { should eq 'ISO, MDY' }
  its('query_group') { should eq 'default' }
  its('require_ssl') { should eq 'false' }
end
EOF
    expect(redshift_cluster_parameter_group.generate_by_parameter_group('my-redshift-cluster-parameter-group')\
      .to_s.gsub(/\n/, "\n")).to eq spec
  end
end
