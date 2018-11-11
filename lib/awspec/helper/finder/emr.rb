module Awspec::Helper
  module Finder
    module Emr
      def find_emr_cluster(cluster_id)
        emr_client.describe_cluster({ cluster_id: cluster_id }).cluster
      end
    end
  end
end
