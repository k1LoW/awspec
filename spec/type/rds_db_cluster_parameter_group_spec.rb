# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'rds_db_cluster_parameter_group'

describe rds_db_cluster_parameter_group('my-rds-db-cluster-parameter-group') do
  it { should exist }
  its(:time_zone) { should eq 'US/Central' }
  its(:binlog_format) { should eq 'ROW' }
  its(:character_set_server) { should eq 'utf8mb4' }
end
