module Awspec::Type
  class RdsDbParameterGroup < Resource
    def resource_via_client
      return @resource_via_client if @resource_via_client

      parameters = {}
      res = rds_client.describe_db_parameters({
                                                db_parameter_group_name: @display_name
                                              })

      loop do
        res.parameters.each do |param|
          parameters[param.parameter_name] = param.parameter_value
        end
        (res.next_page? && res = res.next_page) || break
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
