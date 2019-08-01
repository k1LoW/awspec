Aws.config[:cloudtrail] = {
  stub_responses: {
    describe_trails: {
      trail_list: [
        {
          name: 'my-trail',
          include_global_service_events: true,
          is_multi_region_trail: true,
          log_file_validation_enabled: true,
          trail_arn: 'my-trail-arn'
        }
      ]
    },
    get_trail_status: {
      is_logging: true
    },
    list_tags: {
      resource_tag_list: [
        {
          resource_id: 'my-trail-arn',
          tags_list: [
            {
              key: 'key_one',
              value: 'value_one'
            },
            {
              key: 'key_two',
              value: 'value_two'
            }
          ]
        }
      ]
    }
  }
}
