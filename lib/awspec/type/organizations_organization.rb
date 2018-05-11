module Awspec::Type
  class OrganizationsOrganization < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_organization
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    STATUSES = %w(
      ENABLED PENDING_ENABLE PENDING_DISABLE
    )
    STATUSES.each do |status|
      define_method "service_control_policy_#{status.downcase}?" do
        return false if resource_via_client.available_policy_types.size != 1
        policy = resource_via_client.available_policy_types.first
        policy.status == status
      end
    end
  end
end
