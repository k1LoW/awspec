# frozen_string_literal: true

RSpec::Matchers.define :have_plan_rule do |rule_id|
  match do |plan|
    plan.has_plan_rule?(rule_id,
                        rule_name: @rule_name,
                        target_backup_vault_name: @target_backup_vault_name,
                        schedule_expression: @schedule_expression,
                        start_window_minutes: @start_window_minutes,
                        completion_window_minutes: @completion_window_minutes,
                        lifecycle: @lifecycle,
                        enable_continuous_backup: @enable_continuous_backup,
                        schedule_expression_timezone: @schedule_expression_timezone)
  end

  chain :rule_name do |rule_name|
    @rule_name = rule_name
  end

  chain :target_backup_vault_name do |target_backup_vault_name|
    @target_backup_vault_name = target_backup_vault_name
  end

  chain :schedule_expression do |schedule_expression|
    @schedule_expression = schedule_expression
  end

  chain :start_window_minutes do |start_window_minutes|
    @start_window_minutes = start_window_minutes
  end

  chain :completion_window_minutes do |completion_window_minutes|
    @completion_window_minutes = completion_window_minutes
  end

  chain :lifecycle do |lifecycle|
    @lifecycle = lifecycle
  end

  chain :enable_continuous_backup do |enable_continuous_backup|
    @enable_continuous_backup = enable_continuous_backup
  end

  chain :schedule_expression_timezone do |schedule_expression_timezone|
    @schedule_expression_timezone = schedule_expression_timezone
  end
end
