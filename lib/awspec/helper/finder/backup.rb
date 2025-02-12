# frozen_string_literal: true

module Awspec::Helper
    module Finder
      module Backup
        def find_backup_vault(id)
          res = backup_client.list_backup_vaults
          res.backup_vault_list.select do |v|
            v.backup_vault_name == id || v.backup_vault_arn == id
          end.single_resource(id)
        rescue Aws::Backup::Errors::ResourceNotFoundException
          nil
        end

        def find_backup_plan(id)
          res = backup_client.list_backup_plans
          res.backup_plans_list.select do |p|
            p.backup_plan_name == id || p.backup_plan_arn == id || p.backup_plan_id == id
          end.single_resource(id)
        rescue Aws::Backup::Errors::ResourceNotFoundException
          nil
        end

        def find_backup_selection(id)
          selected = []
          plans = backup_client.list_backup_plans
          plans.backup_plans_list.each do |p|
            res = backup_client.list_backup_selections({backup_plan_id: p.backup_plan_id})
            selected += res.backup_selections_list.select do |s|
              s.selection_id == id || s.selection_name == id
            end
          end
          selected.single_resource(id)
        rescue Aws::Backup::Errors::ResourceNotFoundException
          nil
        end

        def locked?
          return resource_via_client.locked
        end

        def airgapped?
          return resource_via_client.vault_type == 'LOGICALLY_AIR_GAPPED_BACKUP_VAULT'
        end

        STATES = %w[
          creating available failed
        ]
        STATES.each do |state|
          define_method "#{state}?" do
            resource_via_client.vault_state.downcase == state
          end
        end
      end
    end
end
