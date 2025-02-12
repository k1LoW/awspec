# copyright (c) 2025 Atlassian US, Inc.
Aws.config[:backup] = {
  stub_responses: {
    list_backup_plans: {
        backup_plans_list: [
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
    list_backup_selections: {
        backup_selections_list: [
            selection_id: '01dfb41f-c3ca-4b45-91e7-63ef43fe7231',
            selection_name: 'my-backup-selection',
            backup_plan_id: 'fff3e784-1a0f-4e7c-8fe9-ba69825f7c00',
            creation_date: Time.new(2016, 10, 4, 9, 00, 00, '+00:00'),
            creator_request_id: nil,
            iam_role_arn: 'arn:aws:iam::111122223333:role/service-role/my-backup-service-role'
        ]
    }
  }
}
