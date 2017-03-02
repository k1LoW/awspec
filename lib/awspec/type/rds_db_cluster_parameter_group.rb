module Awspec::Type
  class RdsDbClusterParameterGroup < ResourceBase
    def resource_via_client
      return @resource_via_client if @resource_via_client

      parameters = {}
      res = rds_client.describe_db_cluster_parameters({
                                                        db_cluster_parameter_group_name: @display_name
                                                      })

      loop do
        res.parameters.each do |param|
          parameters[param.parameter_name] = param.parameter_value
        end
        (res.respond_to?(:next_page?) && res.next_page? && res = res.next_page) || break
      end

      @resource_via_client ||= parameters
    end

    def id
      @id ||= @display_name unless resource_via_client.empty?
    end

    def method_missing(name)
      param_name = name.to_s
      if resource_via_client.include?(param_name)
        resource_via_client[param_name].to_s
      else
        super
      end
    end
  end
end
