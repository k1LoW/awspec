module Awspec::Helper
  module Finder
    module Eks
      def find_eks_cluster(name)
        res = eks_client.describe_cluster({ name: name })
        res.cluster
      end
    end
  end
end
