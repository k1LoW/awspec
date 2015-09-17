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

    def has_cache_parameter_group?(group_name)
      @resource[:cache_parameter_group][:cache_parameter_group_name] == group_name
    end

    def vpc_id
      cache_subnet_group = find_cache_subnet_group(@resource[:cache_subnet_group_name])
      cache_subnet_group[:vpc_id] if cache_subnet_group
    end
  end
end
