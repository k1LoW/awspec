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
        return resource if resource.path == path
      end
      nil
    end

    def has_integration_path?(path)
      check_existence
      self.api_resources.each do |resource|
        next if resource.resource_methods.nil?
        resource.resource_methods.each do |_, method|
          if method.method_integration.http_method == 'AWS'
            aws_path = method.method_integration.uri.match(%r{(\/[^\?]+)\??.*$}).captures[0] # Matches for ARN type path
            return resource if aws_path == path
          end
          uri = Addressable::URI.parse(method.method_integration.uri)
          return resource if uri.path == path
        end
      end
      nil
    end

    def has_method?(path, http_method)
      check_existence
      resource_to_check = has_path?(path)
      return nil if resource_to_check.nil?
      resource_to_check.resource_methods.each do |_, method|
        return resource_to_check if method.http_method == http_method
      end
      nil
    end

    def has_integration_method?(integration_path, http_method)
      check_existence
      integration_resource_to_check = has_integration_path?(integration_path)
      return nil if integration_resource_to_check.nil?
      integration_resource_to_check.resource_methods.each do |_, method|
        return integration_resource_to_check if method.method_integration.http_method == http_method
      end
      nil
    end
  end
end
