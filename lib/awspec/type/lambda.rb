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

    def handler
      lambda_config.handler
    end

    def description
      lambda_config.description
    end

    def runtime
      lambda_config.runtime
    end

    def code_size
      lambda_config.code_size
    end

    def function_name
      lambda_config.function_name
    end

    def function_arn
      lambda_config.function_arn
    end

    def kms_key_arn
      lambda_config.kms_key_arn
    end

    def has_event_source?(event_source_arn)
      sources = select_event_source_by_function_arn(id)
      sources.find do |source|
        source.event_source_arn == event_source_arn
      end
    end
  end
end
