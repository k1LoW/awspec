module Awspec::Type
  class CognitoIdentityPool < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_identitypool_by_name(@display_name)
    end

    def id
      @id ||= resource_via_client.identity_pool_id if resource_via_client
    end
  end
end
