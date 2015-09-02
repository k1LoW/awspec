module Awspec::Type
  class IamUser < Base
    attr_reader :user

    def initialize(id)
      super
      @user = find_iam_user(id)
      @id = @user[:user_id] if @user
    end

    def method_missing(name)
      describe = name.to_sym
      if @user.members.include?(describe)
        @user[describe]
      else
        super
      end
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_user_name(@user[:user_name])
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end
  end
end
