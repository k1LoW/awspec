module Awspec::Type
  class Msk < ResourceBase
    def initialize(name)
      super
      @desplay_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_msk_cluster_by_name(@display_name)
    end

    def id
      @id ||= resource_via_client.cluster_arn if resource_via_client
    end

    STATES = %w(
      active creating updating
      deleting failed
    )

    STATES.each do |state|
      define_method state + '?' do
        resource_via_client.state == state.upcase
      end
    end
  end
end
