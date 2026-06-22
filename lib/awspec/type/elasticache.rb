# frozen_string_literal: true

module Awspec::Type
  class Elasticache < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      return @resource_via_client if @resource_via_client

      @resource_via_client = find_cache_cluster(@display_name)
      @resource_via_client ||= find_replication_group(@display_name)
      @resource_via_client ||= find_serverless_cache(@display_name)
      @resource_via_client ||= infer_replication_group_from_cluster_prefix
    end

    def id
      return @id if @id
      return nil unless resource_via_client

      @id = if cache_cluster?
              resource_via_client.cache_cluster_id
            elsif serverless?
              resource_via_client.serverless_cache_name
            else
              resource_via_client.replication_group_id
            end
    end

    STATES = %w[
      available creating deleted deleting
      incompatible-network modifying
      rebooting-cache-cluster-nodes restore-failed
      snapshotting
    ]

    STATES.each do |state|
      define_method "#{state.tr('-', '_')}?" do
        resource_status == state
      end
    end

    def has_cache_parameter_group?(group_name)
      return false unless resource_via_client

      if resource_via_client.respond_to?(:cache_parameter_group) && resource_via_client.cache_parameter_group
        return resource_via_client.cache_parameter_group.cache_parameter_group_name == group_name
      end

      if resource_via_client.respond_to?(:cache_parameter_group_name)
        return resource_via_client.cache_parameter_group_name == group_name
      end

      false
    end

    def has_security_group?(sg_id)
      return true if has_vpc_security_group_id?(sg_id)
      return true if has_vpc_security_group_name?(sg_id)
      return true if has_vpc_security_group_tag_name?(sg_id)
    end

    def vpc_id
      return nil unless resource_via_client
      return nil unless resource_via_client.respond_to?(:cache_subnet_group_name)

      cache_subnet_group = find_cache_subnet_group(resource_via_client.cache_subnet_group_name)
      cache_subnet_group.vpc_id if cache_subnet_group
    end

    def cache_type
      return nil unless resource_via_client

      return 'cache_cluster' if cache_cluster?
      return 'serverless_cache' if serverless?

      'replication_group'
    end

    def serverless
      serverless?
    end

    def cache_cluster?
      resource_via_client&.respond_to?(:cache_cluster_id)
    end

    def serverless?
      resource_via_client&.respond_to?(:serverless_cache_name)
    end

    def replication_group?
      return false unless resource_via_client

      !cache_cluster? && !serverless?
    end

    def engine
      return nil unless resource_via_client
      return resource_via_client.engine if resource_via_client.respond_to?(:engine)

      nil
    end

    def engine_version
      return nil unless resource_via_client
      return resource_via_client.engine_version if resource_via_client.respond_to?(:engine_version)
      return resource_via_client.major_engine_version if resource_via_client.respond_to?(:major_engine_version)

      return engine_version_from_member_clusters if replication_group?

      nil
    end

    def cluster_mode_enabled
      return false unless replication_group?
      return resource_via_client.cluster_enabled if resource_via_client.respond_to?(:cluster_enabled)
      return resource_via_client.cluster_mode if resource_via_client.respond_to?(:cluster_mode)

      false
    end

    def num_nodes
      return resource_via_client.num_cache_nodes if cache_cluster?
      return nil if serverless?

      if resource_via_client.respond_to?(:node_groups) && resource_via_client.node_groups
        return resource_via_client.node_groups.sum do |group|
          next 0 unless group.respond_to?(:node_group_members)

          group.node_group_members&.count.to_i
        end
      end

      return resource_via_client.member_clusters.count if resource_via_client.respond_to?(:member_clusters)

      nil
    end

    def node_count
      num_nodes
    end

    private
    def engine_version_from_member_clusters
      cluster_ids = member_cluster_ids
      return nil if cluster_ids.empty?

      clusters = @cache_clusters ||= select_cache_clusters
      cluster = clusters.find { |item| cluster_ids.include?(item.cache_cluster_id) }
      cluster&.engine_version
    end

    def member_cluster_ids
      if resource_via_client.respond_to?(:member_clusters) && resource_via_client.member_clusters
        return resource_via_client.member_clusters.compact
      end

      if resource_via_client.respond_to?(:node_groups) && resource_via_client.node_groups
        return resource_via_client.node_groups.flat_map do |group|
          next [] unless group.respond_to?(:node_group_members)

          group.node_group_members&.map { |member| member.cache_cluster_id } || []
        end.compact
      end

      []
    end

    def infer_replication_group_from_cluster_prefix
      group_id = infer_replication_group_id_from_cluster_prefix(@display_name)
      return nil unless group_id

      find_replication_group(group_id)
    end

    def resource_status
      return nil unless resource_via_client
      return resource_via_client.cache_cluster_status if cache_cluster?
      return resource_via_client.status if resource_via_client.respond_to?(:status)

      nil
    end

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
      return [] unless resource_via_client

      if resource_via_client.respond_to?(:security_groups) && resource_via_client.security_groups
        return resource_via_client.security_groups.map(&:security_group_id)
      end

      return resource_via_client.security_group_ids if resource_via_client.respond_to?(:security_group_ids)

      []
    end
  end
end
