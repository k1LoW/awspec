# frozen_string_literal: true

module Awspec::Type
  class BackupPlan < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_backup_plan(@display_name)
    end

    def id
      @id ||= resource_via_client.backup_plan_id if resource_via_client
    end

    # rubocop:disable Metrics/ParameterLists
    def has_plan_rule?(rule_id,
                       rule_name: nil,
                       target_backup_vault_name: nil,
                       schedule_expression: nil,
                       start_window_minutes: nil,
                       completion_window_minutes: nil,
                       lifecycle: nil,
                       enable_continuous_backup: nil,
                       schedule_expression_timezone: nil)
      rules = select_backup_rule_by_plan_id(resource_via_client.backup_plan_id)
      rules.find do |rule|
        next false if !rule_id.nil? && rule.rule_id != rule_id && rule.rule_name != rule_id
        next false if !rule_name.nil? && rule.rule_name != rule_name
        next false if !target_backup_vault_name.nil? && rule.target_backup_vault_name != target_backup_vault_name
        next false if !schedule_expression.nil? && rule.schedule_expression != schedule_expression
        next false if !start_window_minutes.nil? && rule.start_window_minutes != start_window_minutes
        next false if !completion_window_minutes.nil? && rule.completion_window_minutes != completion_window_minutes
        next false if !enable_continuous_backup.nil? && rule.enable_continuous_backup != enable_continuous_backup
        next false if !schedule_expression_timezone.nil? && \
                      rule.schedule_expression_timezone != schedule_expression_timezone
        next false if !lifecycle.nil? && !_lifecycle_is_equal?(rule.lifecycle, lifecycle)

        true
      end
    end

    private

    def _lifecycle_is_equal?(lc1, lc2)
      lc2_j = JSON.parse lc2
      ret = false
      %w[move_to_cold_storage_after_days delete_after_days opt_in_to_archive_for_supported_resources].each do |attr|
        ret = true if !lc1[attr].nil? && lc2.include?(attr) && lc1[attr].to_s.strip == lc2_j[attr].to_s.strip
      end
      ret
    rescue JSON::ParserError
      raise ArgumentError, "Lifecycle value '#{lc2}' is not valid JSON"
    end
  end
end
