module Awspec::Type
  class AlbListener < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_alb_listener(@display_name)
    end

    def id
      @id ||= resource_via_client.listener_arn if resource_via_client
    end
  end
end
