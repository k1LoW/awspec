module Awspec::Type
  class Eip < ResourceBase
    def resource_via_client
      @resource_via_client ||= select_eip_by_public_ip(@display_name)
    end

    def id
      @id ||= resource_via_client.last.public_ip if resource_via_client
    end

    def associated_to?(instance_id)
      return false unless resource_via_client.last.instance_id == instance_id
      resource_via_client.last.instance_id == instance_id
    end
  end
end
