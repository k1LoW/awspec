Aws.config[:redshift] = {
  stub_responses: {
    describe_cluster_parameters: {
      parameters: [
        {
          parameter_name: 'datestyle',
          parameter_value: 'ISO, MDY'
        },
        {
          parameter_name: 'query_group',
          parameter_value: 'default'
        },
        {
          parameter_name: 'require_ssl',
          parameter_value: 'false'
        }
      ]
    }
  }
}
