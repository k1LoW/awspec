module Awspec::Type
  class IamUser < Base
    def initialize(id)
      super
      @resource = find_iam_user(id)
      @id = @resource[:user_id] if @resource
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_user_name(@resource[:user_name])
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end
  end
end
