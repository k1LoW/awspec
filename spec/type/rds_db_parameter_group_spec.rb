require 'spec_helper'
require 'stub/rds_db_parameter_group'

describe rds_db_parameter_group('my-rds-db-parameter-group') do
  it { should exist }
  its(:basedir) { should eq '/rdsdbbin/mysql' }
  its(:innodb_buffer_pool_size) { '{DBInstanceClassMemory*3/4}' }
end
