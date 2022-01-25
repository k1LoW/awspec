# frozen_string_literal: true

module Awspec::Type
  class InvalidRdsDbParameter < StandardError
    ##
    # Overrides the superclass initialize method to include more information
    # and default error message.
    # Expected parameters:
    # - parameter_name: the name of the parameter.

    def initialize(parameter_name)
      @param_name = parameter_name
      message = "There is no such parameter \"rds.#{parameter_name}\""
      super message
    end
  end

  class RdsDBParameters
    ##
    # Thanks to AWS for creating parameters names like
    # 'rds.accepted_password_auth_method', which would be caught as method 'rds'
    # by method_missing in RdsDbParameterGroup class, this class was created
    # See https://github.com/k1LoW/awspec/issues/527 for more details
    def initialize(params)
      @params = params
    end

    def to_s
      return "RdsDBParameters = #{@params}"
    end

    def method_missing(name)
      param_name = name.to_sym
      return @params[param_name] if @params.include?(param_name)

      raise InvalidRdsDbParameter, name
    end
  end

  class RdsDbParameterGroup < ResourceBase
    def resource_via_client
      return @resource_via_client if @resource_via_client

      @resource_via_client ||= select_all_rds_db_parameters(@display_name)
    end

    def id
      @id ||= @display_name unless resource_via_client.empty?
    end

    def method_missing(name)
      param_name = name.to_s
      return create_rds_params if param_name == 'rds'

      if resource_via_client.include?(param_name)
        resource_via_client[param_name].to_s
      else
        super
      end
    end

    private

    def create_rds_params
      return @rds_params if @rds_params

      rds_params_keys = resource_via_client.keys.select { |key| key.to_s.start_with?('rds.') }
      rds_params = {}

      rds_params_keys.each do |key|
        new_key = key.split('.')[-1]
        rds_params[new_key.to_sym] = resource_via_client[key]
      end

      @rds_params = RdsDBParameters.new(rds_params)
      @rds_params
    end
  end
end
