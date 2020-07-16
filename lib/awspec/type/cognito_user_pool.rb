module Awspec::Type
  class CognitoUserPool < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_userpool_by_name(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end
  end
end
