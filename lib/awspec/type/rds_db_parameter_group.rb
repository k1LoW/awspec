module Awspec::Type
  class RdsDbParameterGroup < Base
    attr_reader :parameters

    def initialize(name)
      super
      @parameters = {}

      marker = nil
      while @parameters.empty? || !marker.nil?
        res = @rds_client.describe_db_parameters(
          db_parameter_group_name: name,
          marker: marker)
        marker = res.marker
        break if res.parameters.empty?
        res.parameters.each do |param|
          @parameters[param.parameter_name] = param.parameter_value
        end
      end
      @id = name unless @parameters.empty?
      @resource = @parameters
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
