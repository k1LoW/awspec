require 'spec_helper'
Awspec::Stub.load 'redshift_cluster_parameter_group'

describe redshift_cluster_parameter_group('my-redshift-cluster-parameter-group') do
  its('datestyle') { should eq 'ISO, MDY' }
  its('query_group') { should eq 'default' }
  its('require_ssl') { should eq 'false' }
end
