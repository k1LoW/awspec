module Awspec::Type
  class Lambda < Base
    attr_reader :function

    def initialize(id)
      super
      @function = find_lambda(id)
      @id = @function[:function_arn] if @function
    end

    def method_missing(name)
      describe = name.to_sym
      if @function.members.include?(describe)
        @function[describe]
      else
        super
      end
    end

    def timeout
      @function[:timeout]
    end

    def has_event_source?(event_source_arn)
      sources = select_event_source_by_function_arn(@id)
      sources.find do |source|
        source.event_source_arn == event_source_arn
      end
    end
  end
end
