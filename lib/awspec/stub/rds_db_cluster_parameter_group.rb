Aws.config[:rds] = {
  stub_responses: {
    describe_db_cluster_parameters: {
      parameters: [
        {
          parameter_name: 'time_zone',
          parameter_value: 'US/Central'
        },
        {
          parameter_name: 'binlog_format',
          parameter_value: 'ROW'
        },
        {
          parameter_name: 'character_set_server',
          parameter_value: 'utf8mb4'
        }
      ]
    }
  }
}
