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
        nil
      end

      def find_replication_group(id)
        res = elasticache_client.describe_replication_groups({
                                                               replication_group_id: id
                                                             })
        res.replication_groups.single_resource(id)
      rescue StandardError
        nil
      end

      def find_serverless_cache(name)
        res = elasticache_client.describe_serverless_caches({
                                                              serverless_cache_name: name
                                                            })
        res.serverless_caches.single_resource(name)
      rescue StandardError
        nil
      end

      def find_cache_subnet_group(group_name)
        res = elasticache_client.describe_cache_subnet_groups({
                                                                cache_subnet_group_name: group_name
                                                              })
        res.cache_subnet_groups.single_resource(group_name)
      end
    end
  end
end
