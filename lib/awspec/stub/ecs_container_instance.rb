Aws.config[:ecs] = {
  stub_responses: {
    describe_container_instances: {
      container_instances: [
        {
          agent_connected: true,
          container_instance_arn:
            'arn:aws:ecs:us-east-1:123456789012:container-instance/f2756532-8f13-4d53-87c9-aed50dc94cd7',
          ec2_instance_id: 'i-01234567',
          pending_tasks_count: 0,
          registered_resources: [
            {
              name: 'CPU',
              type: 'INTEGER',
              double_value: 0.0,
              integer_value: 2048,
              long_value: 0
            },
            {
              name: 'MEMORY',
              type: 'INTEGER',
              double_value: 0.0,
              integer_value: 3768,
              long_value: 0
            },
            {
              name: 'PORTS',
              type: 'STRINGSET',
              double_value: 0.0,
              integer_value: 0,
              long_value: 0,
              string_set_value: %w[
                '2376',
                '22',
                '51678',
                '2375'
              ]
            }
          ],
          remaining_resources: [
            {
              name: 'CPU',
              type: 'INTEGER',
              double_value: 0.0,
              integer_value: 1948,
              long_value: 0
            },
            {
              name: 'MEMORY',
              type: 'INTEGER',
              double_value: 0.0,
              integer_value: 3668,
              long_value: 0
            },
            {
              name: 'PORTS',
              type: 'STRINGSET',
              double_value: 0.0,
              integer_value: 0,
              long_value: 0,
              string_set_value: %w[
                '2376',
                '22',
                '80',
                '51678',
                '2375'
              ]
            }
          ],
          running_tasks_count: 1,
          status: 'ACTIVE'
        }
      ],
      failures: [
      ]
    }
  }
}
