Aws.config[:ecs] = {
  stub_responses: {
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
