module Awspec::Type
  class IamRole < Base
    def initialize(id)
      super
      @resource_via_client = find_iam_role(id)
      @id = @resource_via_client[:role_id] if @resource_via_client
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_role_name(@resource_via_client[:role_name])
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end
  end
end
