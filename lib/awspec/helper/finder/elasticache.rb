module Awspec::Helper
  module Finder
    module Elasticache
      def find_cache_cluster(id)
        res = @elasticache_client.describe_cache_clusters({
                                                            cache_cluster_id: id
                                                          })
        res[:cache_clusters].first if res[:cache_clusters].count == 1
      rescue
        nil
      end

      def find_cache_subnet_group(group_name)
        res = @elasticache_client.describe_cache_subnet_groups({
                                                                 cache_subnet_group_name: group_name
                                                               })
        res[:cache_subnet_groups].first if res[:cache_subnet_groups].count == 1
      end
    end
  end
end
