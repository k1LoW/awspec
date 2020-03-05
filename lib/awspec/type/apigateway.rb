require 'addressable/uri'

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

    def api_resources
      @api_resources.nil? ? @api_resources = find_api_resources_by_id(@id) : @api_resources
    end

    def has_path?(path)
      check_existence
      self.api_resources.each do |resource|
        return true if resource.path == path
      end
      false
    end

    def has_integration_path?(path)
      check_existence
      self.api_resources.each do |resource|
        next if resource.resource_methods.nil?
        resource.resource_methods.each do |_, value|
          uri = Addressable::URI.parse(value.method_integration.uri)
          return true if uri.path == path
        end
      end
      false
    end
  end
end
