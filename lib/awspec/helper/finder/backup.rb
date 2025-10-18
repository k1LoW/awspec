# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Backup
      def find_backup_vault(id)
        selected = []
        req = {}
        loop do
          res = backup_client.list_backup_vaults(req)
          selected += res.backup_vault_list.select do |v|
            v.backup_vault_name == id || v.backup_vault_arn == id
          end
          break if res.next_token.nil?

          req[:next_token] = res.next_token
        end
        selected.single_resource(id)
      rescue Aws::Backup::Errors::ResourceNotFoundException
        nil
      end

      def find_backup_plan(id)
        selected = []
        req = {}
        loop do
          res = backup_client.list_backup_plans(req)
          selected += res.backup_plans_list.select do |p|
            p.backup_plan_name == id || p.backup_plan_arn == id || p.backup_plan_id == id
          end
          break if res.next_token.nil?

          req[:next_token] = res.next_token
        end
        selected.single_resource(id)
      rescue Aws::Backup::Errors::ResourceNotFoundException
        nil
      end

      def find_backup_selection(id)
        backup_plans = []
        req = {}
        loop do
          res = backup_client.list_backup_plans(req)
          backup_plans += res.backup_plans_list.map { |p| p.backup_plan_id }
          break if res.next_token.nil?

          req[:next_token] = res.next_token
        end

        selected = []
        next_token = nil

        backup_plans.each do |plan_id|
          loop do
            res = backup_client.list_backup_selections({ backup_plan_id: plan_id, next_token: next_token })
            selected += res.backup_selections_list.select do |s|
              s.selection_id == id || s.selection_name == id
            end
            break if res.next_token.nil?

            next_token = res.next_token
          end
        end
        selected.single_resource(id)
      rescue Aws::Backup::Errors::ResourceNotFoundException
        nil
      end

      def select_backup_rule_by_plan_id(id)
        selected = []
        req = { backup_plan_id: id }
        res = backup_client.get_backup_plan(req)
        selected = res.backup_plan.rules
      rescue Aws::Backup::Errors::ResourceNotFoundException
        nil
      end

      def locked?
        resource_via_client.locked
      end

      def airgapped?
        resource_via_client.vault_type == 'LOGICALLY_AIR_GAPPED_BACKUP_VAULT'
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
