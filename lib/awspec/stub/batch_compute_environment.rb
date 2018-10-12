Aws.config[:batch] = {
  stub_responses: {
    describe_compute_environments: {
      compute_environments: [
        {
          type: 'MANAGED',
          compute_environment_arn: 'arn:aws:batch:us-east-1:012345678910:compute-environment/P2OnDemand',
          compute_environment_name: 'P2OnDemand',
          compute_resources: {
            type: 'EC2',
            desiredv_cpus: 48,
            ec2_key_pair: 'id_rsa',
            instance_role: 'ecsInstanceRole',
            instance_types: %w[
              p2
            ],
            maxv_cpus: 128,
            minv_cpus: 0,
            security_group_ids: %w[
              sg-cf5093b2
            ],
            subnets: %w[
              subnet-220c0e0a
              subnet-1a95556d
              subnet-978f6dce
            ],
            tags: {
              'name' => 'Batch Instance - P2OnDemand'
            }
          },
          ecs_cluster_arn: 'arn:aws:ecs:us-east-1:012345678910:cluster/P2OnDemand_Batch_2c06f29d-d1fe-3a49-879d',
          service_role: 'arn:aws:iam::012345678910:role/AWSBatchServiceRole',
          state: 'ENABLED',
          status: 'VALID',
          status_reason: 'ComputeEnvironment Healthy'
        }
      ]
    }
  }
}
