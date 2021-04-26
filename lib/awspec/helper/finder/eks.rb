module Awspec::Helper
  module Finder
    module Eks
      def find_eks_cluster(name)
        res = eks_client.describe_cluster({ name: name })
        res.cluster
      end

      def find_eks_nodegroup(cluster_name, group_name)
        res = eks_client.describe_nodegroup({ cluster_name: cluster_name, nodegroup_name: group_name })
        res.nodegroup
      end
    end
  end
end
