module Awspec::Type
  class CloudwatchAlarm < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_cloudwatch_alarm(@display_name)
    end

    def id
      @id ||= resource_via_client.alarm_arn if resource_via_client
    end

    def has_ok_action?(name)
      resource_via_client.ok_actions.include?(name)
    end

    def has_alarm_action?(name)
      resource_via_client.alarm_actions.include?(name)
    end

    def has_insufficient_data_action?(name)
      resource_via_client.insufficient_data_actions.include?(name)
    end
  end
end
