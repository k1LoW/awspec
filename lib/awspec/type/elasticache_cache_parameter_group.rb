module Awspec::Type
  class ElasticacheCacheParameterGroup < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      return @resource_via_client if @resource_via_client

      parameters = {}
      res = elasticache_client.describe_cache_parameters({
                                                           cache_parameter_group_name: @display_name
                                                         })

      loop do
        res.parameters.each do |param|
          parameters[param.parameter_name] = param.parameter_value
        end
        break if res.marker.nil?
        res = elasticache_client.describe_cache_parameters({
                                                             cache_parameter_group_name: @display_name,
                                                             marker: res.marker
                                                           })
      end
      @resource_via_client ||= parameters
    end

    def id
      @id ||= @display_name unless resource_via_client.empty?
    end

    def method_missing(name)
      param_name = name.to_s.tr('_', '-')
      if resource_via_client.include?(param_name)
        resource_via_client[param_name].to_s
      else
        super
      end
    end
  end
end
