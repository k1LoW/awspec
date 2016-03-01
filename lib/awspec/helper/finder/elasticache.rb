module Awspec::Helper
  module Finder
    module Elasticache
      def find_cache_cluster(id)
        res = elasticache_client.describe_cache_clusters({
                                                           cache_cluster_id: id
                                                         })
        res.cache_clusters.single_resource(id)
      rescue
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
