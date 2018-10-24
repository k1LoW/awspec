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

    STATES = %w(ENABLED DISABLED)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.state == state
      end
    end

    def has_compute_environment_order?(arn, order)
      resource_via_client.compute_environment_order.each do |res|
        return true if res.compute_environment == arn && res.order == order
      end
      false
    end
  end
end
