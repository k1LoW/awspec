module Awspec::Type
  class IamPolicy < Base
    def initialize(id)
      super
      @resource = find_iam_policy(id)
      @id = @resource[:policy_id] if @resource
    end

    def attachable?
      policy.is_attachable
    end

    def attached_to_user?(user_id = nil)
      users = select_attached_users(@id)
      if user_id
        user = find_iam_user(user_id)
        return false unless user
        users.any? do |u|
          u.user_name == user[:user_name]
        end
      else
        !users.empty?
      end
    end

    def attached_to_group?(group_id = nil)
      groups = select_attached_groups(@id)
      if group_id
        group = find_iam_group(group_id)
        return false unless group
        groups.any? do |g|
          g.group_name == group[:group_name]
        end
      else
        !groups.empty?
      end
    end

    def attached_to_role?(role_id = nil)
      roles = select_attached_roles(@id)
      if role_id
        role = find_iam_role(role_id)
        return false unless role
        roles.any? do |r|
          r.role_name == role[:role_name]
        end
      else
        !roles.empty?
      end
    end
  end
end
