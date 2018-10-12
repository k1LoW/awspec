module Awspec::Type
  class BatchJobQueue < ResourceBase
    def initialize(jobqueue)
      super
      @display_name = jobqueue
    end

    def resource_via_client
      @resource_via_client ||= find_batch_job_queue(@display_name)
    end

    def id
      @id ||= resource_via_client.job_queue_name if resource_via_client
    end
  end
end
