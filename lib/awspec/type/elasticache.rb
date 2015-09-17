module Awspec::Type
  class Elasticache < Base
    def initialize(id)
      super
      @resource = find_cache_cluster(id)
      @id = @resource[:cache_cluster_id] if @resource
    end

    states = %w(
      available creating deleted deleting
      incompatible-network modifying
      rebooting-cache-cluster-nodes restore-failed
      snapshotting
    )

    states.each do |state|
      define_method state.tr('-', '_') + '?' do
        @resource[:cache_cluster_status] == state
      end
    end
  end
end
