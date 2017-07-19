module Awspec::Type
  class Lambda < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_lambda(@display_name)
    end

    def id
      @id ||= resource_via_client.function_arn if resource_via_client
    end

    def timeout
      lambda_config.timeout
    end

    def memory_size
      lambda_config.memory_size
    end

    def role
      lambda_config.role
    end

    def sha_256
      lambda_config.code_sha256
    end

    def environment
      lambda_config.environment.variables
    end

    def tracing_mode
      lambda_config.tracing_config.mode
    end

    def has_event_source?(event_source_arn)
      sources = select_event_source_by_function_arn(id)
      sources.find do |source|
        source.event_source_arn == event_source_arn
      end
    end

    def lambda_config
      lambda_client.get_function_configuration(function_name: id)
    rescue Aws::Lambda::Errors::ServiceError => e
      puts e
    end
  end
end
