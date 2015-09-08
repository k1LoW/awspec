module Awspec::Helper
  module Finder
    module Iam
      def find_iam_user(id)
        selected = []
        res = @iam_client.list_users

        loop do
          selected += res.users.select do |u|
            u.user_name == id || u.user_id == id || u.arn == id
          end
          (res.next_page? && res = res.next_page) || break
        end

        selected.size == 1 && selected.first
      end

      def find_iam_group(id)
        selected = []
        res = @iam_client.list_groups

        loop do
          selected += res.groups.select do |g|
            g.group_name == id || g.group_id == id || g.arn == id
          end
          (res.next_page? && res = res.next_page) || break
        end

        selected.size == 1 && selected.first
      end

      def find_iam_role(id)
        selected = []
        res = @iam_client.list_roles

        loop do
          selected += res.roles.select do |r|
            r.role_name == id || r.role_id == id || r.arn == id
          end
          (res.next_page? && res = res.next_page) || break
        end

        selected.size == 1 && selected.first
      end

      def find_iam_policy(id)
        selected = []
        res = @iam_client.list_policies

        loop do
          selected += res.policies.select do |p|
            p.policy_name == id || p.policy_id == id || p.arn == id
          end
          (res.next_page? && res = res.next_page) || break
        end

        selected.size == 1 && selected.first
      end

      def select_iam_group_by_user_name(user_name)
        res = @iam_client.list_groups_for_user({
                                                 user_name: user_name
                                               })
        res.groups
      end

      def select_iam_policy_by_user_name(user_name)
        res = @iam_client.list_attached_user_policies({
                                                        user_name: user_name
                                                      })
        res.attached_policies
      end

      def select_iam_policy_by_group_name(group_name)
        res = @iam_client.list_attached_group_policies({
                                                         group_name: group_name
                                                       })
        res.attached_policies
      end

      def select_iam_policy_by_role_name(role_name)
        res = @iam_client.list_attached_role_policies({
                                                        role_name: role_name
                                                      })
        res.attached_policies
      end

      def select_all_attached_policies
        selected = []
        res = @iam_client.list_policies

        loop do
          selected += res.policies.select { |p| p.attachment_count > 0 }
          (res.next_page? && res = res.next_page) || break
        end

        selected
      end

      def select_attached_entities(policy_id)
        policy = find_iam_policy(policy_id)
        @iam_client.list_entities_for_policy(policy_arn: policy[:arn])
      end

      def select_attached_users(policy_id)
        entities = select_attached_entities(policy_id)
        entities.policy_users
      end

      def select_attached_groups(policy_id)
        entities = select_attached_entities(policy_id)
        entities.policy_groups
      end

      def select_attached_roles(policy_id)
        entities = select_attached_entities(policy_id)
        entities.policy_roles
      end
    end
  end
end
