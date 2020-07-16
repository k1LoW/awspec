module Awspec::Helper
  module Finder
    module CognitoUserPool
      def find_userpool_by_name(pool_name)
        cognito_identity_provider_client.list_user_pools(max_results: 60).each do |response|
          pools = response.user_pools
          pools.each do |pool|
            return pool if pool.name == pool_name
          end
        end
        nil
      end
    end
  end
end
