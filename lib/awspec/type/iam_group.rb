module Awspec::Type
  class IamGroup < ResourceBase
    aws_resource Aws::IAM::Group

    def resource_via_client
      @resource_via_client ||= find_iam_group(@display_name)
    end

    def id
      @id ||= resource_via_client.group_name if resource_via_client
    end

    def has_iam_user?(user_id)
      user = find_iam_user(user_id)
      return false unless user
      user_name = user.user_name
      groups = select_iam_group_by_user_name(user_name)
      groups.find do |group|
        group.group_name == id
      end
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_group_name(id)
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end

    def has_inline_policy?(policy_name, document = nil)
      return has_any_inline_policies? unless policy_name

      res = iam_client.get_group_policy({
                                          group_name: id,
                                          policy_name: policy_name
                                        })
      return JSON.parse(URI.decode(res.policy_document)) == JSON.parse(document) if document
      res
    end

    private

    def has_any_inline_policies?
      res = iam_client.list_group_policies(group_name: id)
      !res.policy_names.empty?
    end
  end
end
