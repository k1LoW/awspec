module Awspec::Type
  class RdsDbParameterGroup < Base
    attr_reader :parameters

    def initialize(name)
      super
      @parameters = {}
      res = @rds_client.describe_db_parameters({
                                                 db_parameter_group_name: name
                                               })

      loop do
        res.parameters.each do |param|
          @parameters[param.parameter_name] = param.parameter_value
        end
        (res.next_page? && res = res.next_page) || break
      end

      @id = name unless @parameters.empty?
      @resource_via_client = @parameters
    end

    def method_missing(name)
      param_name = name.to_s.tr('_', '-')
      if @parameters.include?(param_name)
        @parameters[param_name].to_s
      else
        super
      end
    end
  end
end
