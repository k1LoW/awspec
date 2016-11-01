Aws.config[:ecs] = {
  stub_responses: {
    describe_clusters: {
      clusters: [
        {
          cluster_arn: "arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster", 
          cluster_name: "my-ecs-cluster", 
          status: "ACTIVE",
        }
      ],
      failures: [
      ],
    },
  }
}
