# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Elasticache
      def find_cache_cluster(id)
        res = elasticache_client.describe_cache_clusters({
                                                           cache_cluster_id: id
                                                         })
        res.cache_clusters.single_resource(id)
      rescue StandardError
        select_cache_clusters.find { |cluster| cluster.cache_cluster_id == id }
      end

      def find_replication_group(id)
        res = elasticache_client.describe_replication_groups({
                                                               replication_group_id: id
                                                             })
        res.replication_groups.single_resource(id)
      rescue StandardError
        select_replication_groups.find { |group| group.replication_group_id == id }
      end

      def find_serverless_cache(name)
        res = elasticache_client.describe_serverless_caches({
                                                              serverless_cache_name: name
                                                            })
        res.serverless_caches.single_resource(name)
      rescue StandardError
        select_serverless_caches.find { |cache| cache.serverless_cache_name == name }
      end

      def find_cache_subnet_group(group_name)
        res = elasticache_client.describe_cache_subnet_groups({
                                                                cache_subnet_group_name: group_name
                                                              })
        res.cache_subnet_groups.single_resource(group_name)
      end

      def select_cache_clusters
        opt = {}
        clusters = []
        loop do
          res = elasticache_client.describe_cache_clusters(opt)
          clusters.push(*res.cache_clusters)
          break if res.marker.nil?

          opt = { marker: res.marker }
        end
        clusters
      rescue StandardError
        []
      end

      def select_replication_groups
        opt = {}
        groups = []
        loop do
          res = elasticache_client.describe_replication_groups(opt)
          groups.push(*res.replication_groups)
          break if res.marker.nil?

          opt = { marker: res.marker }
        end
        groups
      rescue StandardError
        []
      end

      def select_serverless_caches
        opt = {}
        caches = []
        loop do
          res = elasticache_client.describe_serverless_caches(opt)
          caches.push(*res.serverless_caches)
          break if res.next_token.nil?

          opt = { next_token: res.next_token }
        end
        caches
      rescue StandardError
        []
      end
    end
  end
end
