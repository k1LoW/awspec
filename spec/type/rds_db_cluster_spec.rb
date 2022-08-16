# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'rds_db_cluster'

describe rds_db_cluster('my-rds-db-cluster') do
  it { should exist }
  it { should be_available }
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('group-name-sg') }
  it { should have_security_group('my-db-sg') }
  it { should have_cluster_member('my-rds-db-cluster-instance-1').is_writer(true) }
  it { should have_cluster_member('my-rds-db-cluster-instance-2').is_writer(false) }
  its(:db_cluster_parameter_group) { should eq 'default.aurora-mysql5.7' }
  its(:engine) { should eq 'aurora-mysql' }
  its(:engine_version) { should eq '5.7.mysql_aurora.2.10.2' }
  its(:database_name) { should eq 'example_db' }
  its(:storage_encrypted) { should eq false }
  its(:deletion_protection) { should eq false }
  its(:port) { should eq 3306 }
  its(:master_username) { should eq 'username' }
end
