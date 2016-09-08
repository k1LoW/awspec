module Awspec::Type
  class IamGroup < Base
    aws_resource Aws::IAM::Group

    def resource_via_client
      @resource_via_client ||= find_iam_group(@display_name)
    end

    def id
      @id ||= resource_via_client.group_id if resource_via_client
    end

    def has_iam_user?(user_id)
      user = find_iam_user(user_id)
      return false unless user
      user_name = user.user_name
      groups = select_iam_group_by_user_name(user_name)
      groups.find do |group|
        group.group_id == @id
      end
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_group_name(resource_via_client.group_name)
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end

    def has_inline_policy?(policy_name, document = nil)
      res = iam_client.get_group_policy({
                                          group_name: resource_via_client.group_name,
                                          policy_name: policy_name
                                        })
      return JSON.parse(URI.decode(res.policy_document)) == JSON.parse(document) if document
      res
    end
  end
end
