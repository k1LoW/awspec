Aws.config[:cloudtrail] = {
  stub_responses: {
    describe_trails: {
      trail_list: [
        {
          name: 'my-trail',
          include_global_service_events: true,
          is_multi_region_trail: true,
          log_file_validation_enabled: true
        }
      ]
    },
    get_trail_status: {
      is_logging: true
    }
  }
}
