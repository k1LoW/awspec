# frozen_string_literal: true

Aws.config[:backup] = {
  stub_responses: {
    list_backup_plans: {
      backup_plans_list: [
        {
          backup_plan_arn: 'arn:aws:backup:us-west-2:111122223333:backup-plan:a460d5d5-d30b-4631-8014-38c58e3c72ca',
          backup_plan_id: 'a460d5d5-d30b-4631-8014-38c58e3c72ca',
          creation_date: Time.new(2016, 4, 4, 9, 00, 00, '+00:00'),
          deletion_date: nil,
          version_id: 'kMlWPgkmipEb4I9gOEZpdoQiMgxP5KIizKLDhhblGiixgahy',
          backup_plan_name: 'old-obsolete-plan',
          creator_request_id: nil,
          last_execution_date: Time.new(2016, 10, 4, 9, 00, 00, '+00:00'),
          advanced_backup_settings: nil
        },
        {
          backup_plan_arn: 'arn:aws:backup:us-west-2:111122223333:backup-plan:fff3e784-1a0f-4e7c-8fe9-ba69825f7c00',
          backup_plan_id: 'fff3e784-1a0f-4e7c-8fe9-ba69825f7c00',
          creation_date: Time.new(2016, 10, 4, 9, 00, 00, '+00:00'),
          deletion_date: nil,
          version_id: 'disFW7K0dOAjTaMWKYlhEyScjBhmi5kKGf7BrY7i1BG8F8wB',
          backup_plan_name: 'my-backup-plan',
          creator_request_id: nil,
          last_execution_date: Time.new(2025, 10, 4, 9, 00, 00, '+00:00'),
          advanced_backup_settings: nil
        }
      ],
      next_token: nil
    },
    get_backup_plan: {
      backup_plan: {
        backup_plan_name: 'my-backup-plan',
        rules: [
          {
            rule_name: 'my-daily-backup',
            target_backup_vault_name: 'my-backup-vault',
            schedule_expression: 'cron(0 0 * * ? *)',
            start_window_minutes: 360,
            completion_window_minutes: 1440,
            lifecycle: {
              delete_after_days: 7
            },
            rule_id: '8dd6ef67-9eeb-4743-98be-5b4c582ee3d0',
            enable_continuous_backup: false,
            schedule_expression_timezone: 'Etc/UTC'
          },
          {
            rule_name: 'backup-rule-hourly-30-days',
            target_backup_vault_name: 'Default',
            schedule_expression: 'cron(30 * ? * * *)',
            start_window_minutes: 60,
            completion_window_minutes: 1440,
            lifecycle: {
              delete_after_days: 30
            },
            rule_id: 'febe7fd4-c95f-4d26-b502-97adf2fd0cf4',
            enable_continuous_backup: false,
            schedule_expression_timezone: 'Etc/UTC'
          }
        ]
      },
      backup_plan_id: 'fff3e784-1a0f-4e7c-8fe9-ba69825f7c00',
      backup_plan_arn: 'arn:aws:backup:us-west-2:111122223333:backup-plan:fff3e784-1a0f-4e7c-8fe9-ba69825f7c00',
      version_id: 'disFW7K0dOAjTaMWKYlhEyScjBhmi5kKGf7BrY7i1BG8F8wB',
      creation_date: Time.new(2016, 10, 4, 9, 00, 00, '+00:00'),
      last_execution_date: Time.new(2025, 10, 4, 9, 00, 00, '+00:00')
    }
  }
}
