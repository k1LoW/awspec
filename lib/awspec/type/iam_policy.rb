require 'awspec/error'

module Awspec::Type
  class IamPolicy < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_iam_policy(@display_name)
    end

    def id
      @id ||= resource_via_client.policy_id if resource_via_client
    end

    def attachable?
      check_existence
      resource_via_client.is_attachable
    end

    def attached_to_user?(user_id = nil)
      check_existence
      users = select_attached_users(id)
      if user_id
        user = find_iam_user(user_id)
        return false unless user
        users.any? do |u|
          u.user_name == user.user_name
        end
      else
        !users.empty?
      end
    end

    def attached_to_group?(group_id = nil)
      check_existence
      groups = select_attached_groups(@id)
      if group_id
        group = find_iam_group(group_id)
        return false unless group
        groups.any? do |g|
          g.group_name == group.group_name
        end
      else
        !groups.empty?
      end
    end

    def attached_to_role?(role_id = nil)
      check_existence
      roles = select_attached_roles(@id)
      if role_id
        role = find_iam_role(role_id)
        return false unless role
        roles.any? do |r|
          r.role_name == role.role_name
        end
      else
        !roles.empty?
      end
    end
  end
end
