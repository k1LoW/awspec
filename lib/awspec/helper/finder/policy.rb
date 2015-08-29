module Awspec::Helper
  module Finder
    module Policy
      def find_policy(id)
        selected = []
        res = @iam_client.list_policies

        loop do
          selected += res.policies.select{|p| p.policy_name == id }
          (res.next_page? && res = res.next_page) || break
        end

        selected.size == 1 && selected.first
      end

      def select_all_attached_policies
        selected = []
        res = @iam_client.list_policies

        loop do
          selected += res.policies.select{|p| p.attachment_count > 0 }
          (res.next_page? && res = res.next_page) || break
        end

        selected
      end

      def select_attached_entities(arn)
        @iam_client.list_entities_for_policy(policy_arn: arn)
      end

      def select_attached_users(arn)
        entities = select_attached_entities(arn)
        entities.policy_users
      end

      def select_attached_groups(arn)
        entities = select_attached_entities(arn)
        entities.policy_groups
      end

      def select_attached_roles(arn)
        entities = select_attached_entities(arn)
        entities.policy_roles
      end
    end
  end
end
