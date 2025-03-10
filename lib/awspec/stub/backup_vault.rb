# frozen_string_literal: true

Aws.config[:backup] = {
  stub_responses: {
    list_backup_vaults: {
      backup_vault_list: [
        {
          backup_vault_name: 'Default',
          backup_vault_arn: 'arn:aws:backup:us-west-2:111122223333:backup-vault:Default',
          vault_type: 'BACKUP_VAULT',
          vault_state: 'AVAILABLE',
          creation_date: Time.new(2024, 4, 4, 9, 00, 00, '+00:00'),
          encryption_key_arn: 'arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab',
          creator_request_id: 'Default',
          number_of_recovery_points: 0,
          locked: false,
          min_retention_days: nil,
          max_retention_days: nil,
          lock_date: nil
        },
        {
          backup_vault_name: 'my-backup-vault',
          backup_vault_arn: 'arn:aws:backup:us-west-2:111122223333:backup-vault:my-vault',
          vault_type: 'BACKUP_VAULT',
          vault_state: 'AVAILABLE',
          creation_date: Time.new(2024, 4, 4, 9, 00, 00, '+00:00'),
          encryption_key_arn: 'arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab',
          creator_request_id: 'Default',
          number_of_recovery_points: 123,
          locked: true,
          min_retention_days: 7,
          max_retention_days: 35,
          lock_date: Time.new(2024, 10, 4, 9, 00, 00, '+00:00')
        },
        {
          backup_vault_name: 'my-airgapped-vault',
          backup_vault_arn: 'arn:aws:backup:us-west-2:111122223333:backup-vault:my-airgapped-vault',
          vault_type: 'LOGICALLY_AIR_GAPPED_BACKUP_VAULT',
          vault_state: 'AVAILABLE',
          creation_date: Time.new(2024, 4, 4, 9, 00, 00, '+00:00'),
          encryption_key_arn: 'arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab',
          creator_request_id: nil,
          number_of_recovery_points: 12,
          locked: false,
          min_retention_days: 30,
          max_retention_days: 30,
          lock_date: nil
        }
      ],
      next_token: nil
    }
  }
}
