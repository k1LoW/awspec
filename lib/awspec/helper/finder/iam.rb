module Awspec::Helper
  module Finder
    module Iam
      def find_iam_user(id)
        users = []
        marker = nil
        loop do
          res = @iam_client.list_users(
            marker: marker
          )
          marker = res.marker
          break if res.users.empty?
          res.users.each do |user|
            users.push(user) if user.user_name == id || user.user_id == id
          end
          break unless marker
        end
        return users[0] if users.count == 1
      end

      def find_iam_group(id)
        groups = []
        marker = nil
        loop do
          res = @iam_client.list_groups(
            marker: marker
          )
          marker = res.marker
          break if res.groups.empty?
          res.groups.each do |group|
            groups.push(group) if group.group_name == id || group.group_id == id
          end
          break unless marker
        end
        return groups[0] if groups.count == 1
      end

      def find_iam_role(id)
        roles = []
        marker = nil
        loop do
          res = @iam_client.list_roles(
            marker: marker
          )
          marker = res.marker
          break if res.roles.empty?
          res.roles.each do |role|
            roles.push(role) if role.role_name == id || role.role_id == id
          end
          break unless marker
        end
        return roles[0] if roles.count == 1
      end

      def find_iam_policy(id)
        selected = []
        res = @iam_client.list_policies

        loop do
          selected += res.policies.select{|p| p.policy_name == id || p.policy_id == id || p.arn == id }
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
          selected += res.policies.select{|p| p.attachment_count > 0 }
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
