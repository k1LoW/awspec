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
    }
  }
}
