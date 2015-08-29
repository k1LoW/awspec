module Awspec::Type
  class Policy < Base
    attr_reader :policy

    def initialize(id)
      super
      @policy = find_policy(id)
    end

    def exists?
      !!policy
    end

    def attachable?
      policy.is_attachable
    end

    def attached_to_user?(user_name = nil)
      users = select_attached_users(policy.arn)
      if user_name
        users.any?{|g| g.user_name == user_name }
      else
        !users.empty?
      end
    end

    def attached_to_group?(group_name = nil)
      groups = select_attached_groups(policy.arn)
      if group_name
        groups.any?{|g| g.group_name == group_name }
      else
        !groups.empty?
      end
    end

    def attached_to_role?(role_name = nil)
      roles = select_attached_roles(policy.arn)
      if role_name
        roles.any?{|g| g.role_name == role_name }
      else
        !roles.empty?
      end
    end

    def method_missing(name)
      describe = name.to_s
      if policy.key?(describe)
        policy[describe]
      else
        super
      end
    end
  end
end
