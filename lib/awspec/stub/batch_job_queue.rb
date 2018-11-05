Aws.config[:batch] = {
  stub_responses: {
    describe_job_queues: {
      job_queues: [
        {
          compute_environment_order: [
            {
              compute_environment: 'arn:aws:batch:us-east-1:012345678910:compute-environment/C4OnDemand',
              order: 1
            }
          ],
          job_queue_arn: 'arn:aws:batch:us-east-1:012345678910:job-queue/HighPriority',
          job_queue_name: 'HighPriority',
          priority: 1,
          state: 'ENABLED',
          status: 'VALID',
          status_reason: 'JobQueue Healthy'
        }
      ]
    }
  }
}
