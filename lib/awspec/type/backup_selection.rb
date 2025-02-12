# copyright (c) 2025 Atlassian US, Inc.
module Awspec::Type
  class BackupSelection < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_backup_selection(@display_name)
    end

    def id
      @id ||= resource_via_client.selection_id if resource_via_client
    end
  end
end
