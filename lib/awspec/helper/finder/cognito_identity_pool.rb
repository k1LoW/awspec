module Awspec::Helper
  module Finder
    module CognitoIdentityPool
      def find_identitypool_by_name(pool_name)
        cognito_identity_client.list_identity_pools(max_results: 60).each do |response|
          pools = response.identity_pools
          pools.each do |pool|
            return pool if pool.identity_pool_name == pool_name
          end
        end
        nil
      end
    end
  end
end
