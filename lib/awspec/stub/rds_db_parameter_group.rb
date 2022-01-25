# frozen_string_literal: true

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
        },
        {
          parameter_name: 'max_allowed_packet',
          parameter_value: '16777216'
        },
        {
          parameter_name: 'rds.logical_replication',
          parameter_value: '1'
        },
        {
          parameter_name: 'rds.accepted_password_auth_method',
          parameter_value: 'md5+scram'
        }
      ]
    }
  }
}
