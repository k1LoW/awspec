module Awspec::Type
  class CloudwatchAlarm < Base
    def initialize(id)
      super
      @resource = find_cloudwatch_alarm(id)
      @id = @resource[:alarm_arn] if @resource
    end

    def has_ok_action?(name)
      @resource[:ok_actions].include?(name)
    end

    def has_alarm_action?(name)
      @resource[:alarm_actions].include?(name)
    end

    def has_insufficient_data_action?(name)
      @resource[:insufficient_data_actions].include?(name)
    end
  end
end
