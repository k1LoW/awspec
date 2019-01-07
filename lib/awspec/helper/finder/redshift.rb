module Awspec::Helper
  module Finder
    module Redshift
      def find_redshift_cluster_identifier(id)
        res = redshift_client.describe_clusters(cluster_identifier: id)
        res.clusters.single_resource(id)
      rescue
        nil
      end

      def select_redshift_by_vpc_id(vpc_id)
        res = redshift_client.describe_clusters
        res.clusters.select do |clusters|
          clusters.vpc_id == vpc_id
        end
      end
    end
  end
end
