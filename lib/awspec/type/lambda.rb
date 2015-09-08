module Awspec::Type
  class Lambda < Base
    def initialize(id)
      super
      @resource = find_lambda(id)
      @id = @resource[:function_arn] if @resource
    end

    def timeout
      @resource[:timeout]
    end

    def has_event_source?(event_source_arn)
      sources = select_event_source_by_function_arn(@id)
      sources.find do |source|
        source.event_source_arn == event_source_arn
      end
    end
  end
end
