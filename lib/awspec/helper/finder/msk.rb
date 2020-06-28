module Awspec::Helper
  module Finder
    module Msk
      def find_msk_cluster_by_name(cluster_name)
        res = msk_client.list_clusters(
          {
            cluster_name_filter: cluster_name,
            max_results: 1
          }
        )
        res.cluster_info_list[0]
      end
    end
  end
end
