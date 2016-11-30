Aws.config[:ecs] = {
  stub_responses: {
    describe_clusters: {
      clusters: [
        {
          cluster_arn:                           'arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster',
          cluster_name:                          'my-ecs-cluster',
          status:                                'ACTIVE',
          registered_container_instances_count:  0,
          pending_tasks_count:                   0,
          running_tasks_count:                   0,
          active_services_count:                 0
        }
      ],
      failures: [
      ]
    },
    list_container_instances: {
      container_instance_arns: [
        'arn:aws:ecs:us-east-1:123456789012:container-instance/f2756532-8f13-4d53-87c9-aed50dc94cd7'
      ]
    },
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
    },
    describe_task_definition: {
      task_definition: {
        container_definitions: [
          {
            name: 'wordpress',
            cpu: 10,
            environment: [
            ],
            essential: true,
            image: 'wordpress',
            links: [
              'mysql'
            ],
            memory: 500,
            mount_points: [
            ],
            port_mappings: [
              {
                container_port: 80,
                host_port: 80
              }
            ],
            volumes_from: [
            ]
          },
          {
            name: 'mysql',
            cpu: 10,
            environment: [
              {
                name: 'MYSQL_ROOT_PASSWORD',
                value: 'password'
              }
            ],
            essential: true,
            image: 'mysql',
            memory: 500,
            mount_points: [
            ],
            port_mappings: [
            ],
            volumes_from: [
            ]
          }
        ],
        status: 'ACTIVE',
        family: 'my-ecs-task-definition',
        revision: 8,
        task_definition_arn: 'arn:aws:ecs:us-east-1:123456789012:task-definition/my-ecs-task-definition:8',
        task_role_arn: 'arn:aws:iam::123456789012:role/my-iam-role',
        volumes: [
        ]
      }
    },
    describe_services: {
      failures: [
      ],
      services: [
        {
          cluster_arn: 'arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster',
          created_at: Time.parse('2016-08-29T16:25:52.130Z'),
          deployment_configuration: {
            maximum_percent: 200,
            minimum_healthy_percent: 100
          },
          deployments: [
            {
              created_at: Time.parse('2016-08-29T16:25:52.130Z'),
              desired_count: 1,
              id: 'ecs-svc/9223370564341623665',
              pending_count: 0,
              running_count: 0,
              status: 'PRIMARY',
              task_definition: 'arn:aws:ecs:us-east-1:123456789012:task-definition/my-ecs-task-definition:8',
              updated_at: Time.parse('2016-08-29T16:25:52.130Z')
            }
          ],
          desired_count: 1,
          events: [
            {
              created_at: Time.parse('2016-08-29T16:25:58.520Z'),
              id: '38c285e5-d335-4b68-8b15-e46dedc8e88d',
              message: '(service my-ecs-service) was unable to place a task ' \
                'because no container instance met all of its requirements. The ' \
                'closest matching (container-instance ' \
                '3f4de1c5-ffdd-4954-af7e-75b4be0c8841) is already using a port ' \
                'required by your task. For more information, see the ' \
                'Troubleshooting section of the Amazon ECS Developer Guide.'
            }
          ],
          load_balancers: [
          ],
          pending_count: 0,
          running_count: 0,
          service_arn: 'arn:aws:ecs:us-east-1:123456789012:service/my-ecs-service',
          service_name: 'my-ecs-service',
          status: 'ACTIVE',
          task_definition: 'arn:aws:ecs:us-east-1:123456789012:task-definition/my-ecs-task-definition:8'
        }
      ]
    }
  }
}
