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
    }
  }
}
