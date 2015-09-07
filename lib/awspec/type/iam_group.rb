module Awspec::Type
  class IamGroup < Base
    def initialize(id)
      super
      @resource = find_iam_group(id)
      @id = @resource[:group_id] if @resource
    end

    def has_iam_user?(user_id)
      user = find_iam_user(user_id)
      return false unless user
      user_name = user[:user_name]
      groups = select_iam_group_by_user_name(user_name)
      groups.find do |group|
        group.group_id == @id
      end
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_group_name(@resource[:group_name])
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end
  end
end
