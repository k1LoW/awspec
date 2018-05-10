module Awspec::Type
  class OrganizationsAccount < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_account(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    STATUSES = %w(
      ACTIVE SUSPENDED
    )
    STATUSES.each do |status|
      define_method status.downcase + '?' do
        resource_via_client.status == status
      end
    end

    JOIN_METHODS = %w(
      INVITED CREATED
    )
    JOIN_METHODS.each do |joined_method|
      define_method joined_method.downcase + '?' do
        resource_via_client.joined_method == joined_method
      end
    end
  end
end
