Aws.config[:batch] = {
  stub_responses: {
    describe_job_definitions: {
      job_definitions: [
        {
          type: 'container',
          container_properties: {
            command: %w[
              sleep
              60
            ],
            environment: [],
            image: 'busybox',
            memory: 128,
            mount_points: [],
            ulimits: [],
            vcpus: 1,
            volumes: []
          },
          job_definition_arn: 'arn:aws:batch:us-east-1:012345678910:job-definition/sleep60:1',
          job_definition_name: 'sleep60',
          revision: 1,
          status: 'ACTIVE'
        }
      ]
    }
  }
}
