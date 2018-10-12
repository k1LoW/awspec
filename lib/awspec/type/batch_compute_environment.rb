module Awspec::Type
  class BatchComputeEnvironment < ResourceBase
    def initialize(compenv)
      super
      @display_name = compenv
    end

    def resource_via_client
      @resource_via_client ||= find_batch_compute_environment(@display_name)
    end

    def id
      @id ||= resource_via_client.compute_environment_name if resource_via_client
    end
  end
end
