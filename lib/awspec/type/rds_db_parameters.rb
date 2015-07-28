module Awspec::Type
  class RdsDbParameters < Base
    def initialize(name)
      @client = Aws::RDS::Client.new
      @parameters = {}

      marker = nil
      while @parameters.empty? || !marker.nil?
        res = @client.describe_db_parameters(
          db_parameter_group_name: name,
          marker: marker)
        marker = res.marker
        break if res.parameters.empty?
        res.parameters.each do |param|
          @parameters[param.parameter_name] = param.parameter_value
        end
      end
    end

    def method_missing(name)
      param_name = name.to_s
      if @parameters.key?(param_name)
        @parameters[param_name].to_s
      else
        super
      end
    end
  end
end
