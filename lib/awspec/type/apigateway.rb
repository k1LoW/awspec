module Awspec::Type
  class Apigateway < ResourceBase
    aws_resource Aws::APIGateway::Client

    def resource_via_client
      @resource_via_client ||= find_apigateway(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end
  end
end
