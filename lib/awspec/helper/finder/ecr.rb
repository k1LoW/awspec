module Awspec::Helper
  module Finder
    module Ecr
      def find_ecr_repository(repository_name)
        res = ecr_client.describe_repositories(repository_names: [repository_name])
        res.repositories.first if res.repositories.count == 1
      end

      def get_policy_text(repository_name)
        res = ecr_client.get_repository_policy(repository_name: repository_name)[:policy_text]
      end
    end
  end
end
