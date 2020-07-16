module Awspec::Type
  class Secretsmanager < ResourceBase
    aws_resource Aws::SecretsManager
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_secret(@display_name)
    end

    def id
      @id ||= resource_via_client.name if resource_via_client
    end
  end
end
