Aws.config[:ecs] = {
  stub_responses: {
    describe_clusters: {
      clusters: [
        {
          cluster_arn:                           "arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster", 
          cluster_name:                          "my-ecs-cluster", 
          status:                                "ACTIVE",
          registered_container_instances_count:  0,
          pending_tasks_count:                   0,
          running_tasks_count:                   0,
          active_services_count:                 0,
        }
      ],
      failures: [
      ],
    },
    list_container_instances: {
      container_instance_arns: [
        "arn:aws:ecs:us-east-1:123456789012:container-instance/f2756532-8f13-4d53-87c9-aed50dc94cd7"
      ]
    },
    describe_container_instances: {
      container_instances: [
        {
          agent_connected: true, 
          container_instance_arn: "arn:aws:ecs:us-east-1:123456789012:container-instance/f2756532-8f13-4d53-87c9-aed50dc94cd7", 
          ec2_instance_id: "i-01234567", 
          pending_tasks_count: 0, 
          registered_resources: [
            {
              name: "CPU", 
              type: "INTEGER", 
              double_value: 0.0, 
              integer_value: 2048, 
              long_value: 0, 
            }, 
            {
              name: "MEMORY", 
              type: "INTEGER", 
              double_value: 0.0, 
              integer_value: 3768, 
              long_value: 0, 
            }, 
            {
              name: "PORTS", 
              type: "STRINGSET", 
              double_value: 0.0, 
              integer_value: 0, 
              long_value: 0, 
              string_set_value: [
                "2376", 
                "22", 
                "51678", 
                "2375", 
              ], 
            }, 
          ], 
          remaining_resources: [
            {
              name: "CPU", 
              type: "INTEGER", 
              double_value: 0.0, 
              integer_value: 1948, 
              long_value: 0, 
            }, 
            {
              name: "MEMORY", 
              type: "INTEGER", 
              double_value: 0.0, 
              integer_value: 3668, 
              long_value: 0, 
            }, 
            {
              name: "PORTS", 
              type: "STRINGSET", 
              double_value: 0.0, 
              integer_value: 0, 
              long_value: 0, 
              string_set_value: [
                "2376", 
                "22", 
                "80", 
                "51678", 
                "2375", 
              ], 
            }, 
          ], 
          running_tasks_count: 1, 
          status: "ACTIVE", 
        }, 
      ],
      failures: [
      ],
    },
    describe_task_definition: {
      task_definition: {
        container_definitions: [
          {
            name: "wordpress", 
            cpu: 10, 
            environment: [
            ], 
            essential: true, 
            image: "wordpress", 
            links: [
              "mysql", 
            ], 
            memory: 500, 
            mount_points: [
            ], 
            port_mappings: [
              {
                container_port: 80, 
                host_port: 80, 
              }, 
            ], 
            volumes_from: [
            ], 
          }, 
          {
            name: "mysql", 
            cpu: 10, 
            environment: [
              {
                name: "MYSQL_ROOT_PASSWORD", 
                value: "password", 
              }, 
            ], 
            essential: true, 
            image: "mysql", 
            memory: 500, 
            mount_points: [
            ], 
            port_mappings: [
            ], 
            volumes_from: [
            ], 
          }, 
        ],
        status: 'ACTIVE',
        family: "my-ecs-task-definition", 
        revision: 8, 
        task_definition_arn: "arn:aws:ecs:us-east-1:123456789012:task-definition/my-ecs-task-definition:8", 
        task_role_arn: 'arn:aws:iam::123456789012:role/my-iam-role',
        volumes: [
        ], 
      }
    }
  }
}
