module Awspec::Type
  class Apigateway < ResourceBase
    aws_resource Aws::APIGateway::Client

    def cache_values(res)
      @id = res.id
      @name = res.name
      @description = res.description
      @created_date = res.created_date
      @version = res.version
      @warnings = res.warnings
      @binary_media_types = res.binary_media_types
      @minimum_compression_size = res.minimum_compression_size
      @api_key_source = res.api_key_source
      @policy = res.policy
      @endpoint_configuration = res.endpoint_configuration
    end

    def resource_via_client
      return unless @resource_via_client.nil?

      @resource_via_client = find_apigateway_by_id(@display_name)
      return @resource_via_client if @resource_via_client

      @resource_via_client = find_apigateway_by_name(@display_name)
    end

    def id
      cache_values(resource_via_client) if @id.nil?
      @id
    end

    def name
      cache_values(resource_via_client) if @name.nil?
      @name
    end

    def description
      cache_values(resource_via_client) if @description.nil?
      @description
    end

    def created_date
      cache_values(resource_via_client) if @created_date.nil?
      @created_date
    end

    def version
      cache_values(resource_via_client) if @version.nil?
      @version
    end

    def warnings
      cache_values(resource_via_client) if @warnings.nil?
      @warnings
    end

    def binary_media_types
      cache_values(resource_via_client) if @binary_media_types.nil?
      @binary_media_types
    end

    def minimum_compression_size
      cache_values(resource_via_client) if @minimum_compression_size.nil?
      @minimum_compression_size
    end

    def api_key_source
      cache_values(resource_via_client) if @api_key_source.nil?
      @api_key_source
    end

    def policy
      cache_values(resource_via_client) if @policy.nil?
      @policy
    end

    def endpoint_configuration
      cache_values(resource_via_client) if @endpoint_configuration.nil?
      @endpoint_configuration
    end
  end
end
