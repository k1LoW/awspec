module Awspec::Type
  class CloudformationStack < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_cloudformation_stack(@display_name)
    end

    def id
      @id ||= resource_via_client.stack_name if resource_via_client
    end
  end
end
