module Awspec::Type
  class ElastictranscoderPipeline < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_pipeline(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    STATUSES = %w(
      Active Paused
    )

    STATUSES.each do |status|
      define_method status.underscore + '?' do
        resource_via_client.status == status
      end
    end
  end
end
