module Awspec::Type
  class Elasticache < Base
    def initialize(id)
      super
      @resource_via_client = find_cache_cluster(id)
      @id = @resource_via_client.cache_cluster_id if @resource_via_client
    end

    STATES = %w(
      available creating deleted deleting
      incompatible-network modifying
      rebooting-cache-cluster-nodes restore-failed
      snapshotting
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        @resource_via_client.cache_cluster_status == state
      end
    end

    def has_cache_parameter_group?(group_name)
      @resource_via_client.cache_parameter_group.cache_parameter_group_name == group_name
    end

    def vpc_id
      cache_subnet_group = find_cache_subnet_group(@resource_via_client.cache_subnet_group_name)
      cache_subnet_group.vpc_id if cache_subnet_group
    end
  end
end
