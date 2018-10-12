module Awspec::Type
  class BatchJobDefinition < ResourceBase
    def initialize(jobdef)
      super
      @display_name = jobdef
    end

    def resource_via_client
      @resource_via_client ||= find_batch_job_definition(@display_name)
    end

    def id
      @id ||= resource_via_client.job_definition_name if resource_via_client
    end
  end
end
