require 'spec_helper'

Aws.config[:rds] = {
  stub_responses: {
    describe_db_parameters: {
      parameters: [
        {
          parameter_name: 'basedir',
          parameter_value: '/rdsdbbin/mysql'
        },
        {
          parameter_name: 'innodb_buffer_pool_size',
          parameter_value: '{DBInstanceClassMemory*3/4}'
        }
      ]
    }
  }
}

describe rds_db_parameters('test') do
  its(:basedir) { should eq '/rdsdbbin/mysql' }
  its(:innodb_buffer_pool_size) { '{DBInstanceClassMemory*3/4}' }
end
