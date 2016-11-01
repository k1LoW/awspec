module Awspec::Helper
  module Finder
    module Ecs
      def find_ecs_cluster(name)
        # cluster_name
        res = ecs_client.describe_clusters({ clusters: [name] })
          
        res.clusters.first if res.clusters.count == 1
      end
    end
  end
end
