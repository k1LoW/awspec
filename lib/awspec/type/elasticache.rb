module Awspec::Type
  class Elasticache < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_cache_cluster(@display_name)
    end

    def id
      @id ||= resource_via_client.cache_cluster_id if resource_via_client
    end

    STATES = %w(
      available creating deleted deleting
      incompatible-network modifying
      rebooting-cache-cluster-nodes restore-failed
      snapshotting
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.cache_cluster_status == state
      end
    end

    def has_cache_parameter_group?(group_name)
      resource_via_client.cache_parameter_group.cache_parameter_group_name == group_name
    end

    def has_security_group?(sg_id)
      return true if has_vpc_security_group_id?(sg_id)
      return true if has_vpc_security_group_name?(sg_id)
      return true if has_vpc_security_group_tag_name?(sg_id)
    end

    def vpc_id
      cache_subnet_group = find_cache_subnet_group(resource_via_client.cache_subnet_group_name)
      cache_subnet_group.vpc_id if cache_subnet_group
    end

    private

    def has_vpc_security_group_id?(sg_id)
      resource_security_group_ids.include?(sg_id)
    end

    def has_vpc_security_group_name?(sg_id)
      res = select_security_group_by_group_name([sg_id])

      return false unless res.count == 1
      has_vpc_security_group_id?(res.first.group_id)
    end

    def has_vpc_security_group_tag_name?(sg_id)
      res = select_security_group_by_tag_name([sg_id])

      return false unless res.count == 1
      has_vpc_security_group_id?(res.first.group_id)
    end

    def resource_security_group_ids
      resource_via_client.security_groups.map(&:security_group_id)
    end
  end
end
