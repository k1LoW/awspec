module Awspec::Type
  class RdsDbClusterParameterGroup < Base
    def initialize(name)
      super
      @parameters = {}
      res = rds_client.describe_db_cluster_parameters({
                                                        db_cluster_parameter_group_name: name
                                                      })

      loop do
        res.parameters.each do |param|
          @parameters[param.parameter_name] = param.parameter_value
        end
        (res.respond_to?(:next_page?) && res.next_page? && res = res.next_page) || break
      end

      @id = name unless @parameters.empty?
      @resource_via_client = @parameters
    end

    def method_missing(name)
      param_name = name.to_s
      if @parameters.include?(param_name)
        @parameters[param_name].to_s
      else
        super
      end
    end
  end
end
