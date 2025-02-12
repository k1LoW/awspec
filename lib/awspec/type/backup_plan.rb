# copyright (c) 2025 Atlassian US, Inc.
module Awspec::Type
  class BackupPlan < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_backup_plan(@display_name)
    end

    def id
      @id ||= resource_via_client.backup_plan_id if resource_via_client
    end
  end
end
