Aws.config[:ecs] = {
  stub_responses: {
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
    }
  }
}
