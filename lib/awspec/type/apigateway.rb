module Awspec::Type
  class Apigateway < ResourceBase
    aws_resource Aws::APIGateway::Client

    def resource_via_client
      @resource_via_client ||= find_apigateway_by_id(@display_name)
      return @resource_via_client if @resource_via_client
      @resource_via_client = find_apigateway_by_name(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    def has_path?(path)
      check_existence
      all_resources = find_api_resources_by_id(@id)
      all_resources.each do |resource|
        return true if resource.path == path
      end
      false
    end
  end
end
