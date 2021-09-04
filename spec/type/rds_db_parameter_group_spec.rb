require 'spec_helper'
Awspec::Stub.load 'rds_db_parameter_group'

describe rds_db_parameter_group('my-rds-db-parameter-group') do
  it { should exist }
  its(:basedir) { should eq '/rdsdbbin/mysql' }
  its(:innodb_buffer_pool_size) { should eq '{DBInstanceClassMemory*3/4}' }
  its(:max_allowed_packet) { should eq '16777216' }
  its('rds.logical_replication') { should eq '1' }
  its('rds.accepted_password_auth_method') { should eq 'md5+scram' }
  its('rds.foobar') { will raise_error(Awspec::Type::InvalidRdsDbParameter) }
end
