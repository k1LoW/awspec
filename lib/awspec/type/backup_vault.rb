module Awspec::Type
  class BackupVault < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_backup_vault(@display_name)
    end

    def id
      @id ||= resource_via_client.backup_vault_arn if resource_via_client
    end
  end
end
