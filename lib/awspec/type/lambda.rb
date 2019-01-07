module Awspec::Type
  class Lambda < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_lambda(@display_name)
    end

    def id
      @id ||= resource_via_client.function_arn if resource_via_client
    end

    def timeout
      check_existence
      resource_via_client.timeout
    end

    def has_event_source?(event_source_arn)
      sources = select_event_source_by_function_arn(id)
      sources.find do |source|
        source.event_source_arn == event_source_arn
      end
    end
  end
end
