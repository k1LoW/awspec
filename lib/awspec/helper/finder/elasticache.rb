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
    end
  end
end
