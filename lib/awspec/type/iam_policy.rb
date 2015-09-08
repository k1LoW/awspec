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

    def attached_to_user?(user_name = nil)
      users = select_attached_users(@resource.arn)
      if user_name
        users.any?{|g| g.user_name == user_name }
      else
        !users.empty?
      end
    end

    def attached_to_group?(group_name = nil)
      groups = select_attached_groups(@resource.arn)
      if group_name
        groups.any?{|g| g.group_name == group_name }
      else
        !groups.empty?
      end
    end

    def attached_to_role?(role_name = nil)
      roles = select_attached_roles(@resource.arn)
      if role_name
        roles.any?{|g| g.role_name == role_name }
      else
        !roles.empty?
      end
    end
  end
end
