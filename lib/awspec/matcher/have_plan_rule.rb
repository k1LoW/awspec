# frozen_string_literal: true

RSpec::Matchers.define :have_plan_rule do |rule_id|
  attr_list = %w[
    rule_name target_backup_vault_name schedule_expression
    start_window_minutes completion_window_minutes lifecycle
    enable_continuous_backup schedule_expression_timezone
  ]

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

  attr_list.each do |a|
    define_method a.to_sym do |*args|
      instance_variable_set("@#{a}", args[0])
      self
    end
  end

  description do
    attr = ''
    attr_list.each do |a|
      attr += "#{a} #{instance_variable_get("@#{a}")}" unless instance_variable_get("@#{a}").nil?
    end

    attr = " with #{attr}" if attr != ''
    "have plan rule #{rule_id}#{attr}"
  end
end
