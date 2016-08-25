module Awspec::Type
  class CloudwatchEvent < Base
    def initialize(id)
      super
      @resource_via_client = find_cloudwatch_event(id)
      @id = @resource_via_client.arn if @resource_via_client
    end

    def enable?
      @resource_via_client.state == 'ENABLED'
    end

    def scheduled?(schedule)
      @resource_via_client.schedule_expression == schedule
    end
  end
end
