module Awspec::Type
  class OrganizationsAccount < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_account(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end
  end
end
