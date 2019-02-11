module Awspec::Type
  class Codedeploy < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_codedeploy_app(@display_name)
    end

    def id
      @id ||= resource_via_client.application_name if resource_via_client
    end
  end
end
