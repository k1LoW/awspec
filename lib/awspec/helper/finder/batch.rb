module Awspec::Helper
  module Finder
    module Batch
      def find_batch_compute_environment(name)
        res = batch_client.describe_compute_environments(compute_environments: [name], max_results: 1)
        res.compute_environments[0] if res.compute_environments
      end

      def find_batch_job_definition(name)
        res = batch_client.describe_job_definitions(job_definitions: [name], max_results: 1)
        res.job_definitions[0] if res.job_definitions
      end

      def find_batch_job_queue(name)
        res = batch_client.describe_job_queues(job_queues: [name], max_results: 1)
        res.job_queues[0] if res.job_queues
      end
    end
  end
end
