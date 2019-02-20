module Awspec::Type
  class IamRole < ResourceBase
    aws_resource Aws::IAM::Role

    def resource_via_client
      @resource_via_client ||= find_iam_role(@display_name)
    end

    def id
      @id ||= resource_via_client.role_name if resource_via_client
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_role_name(resource_via_client.role_name)
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end

    def has_inline_policy?(policy_name, document = nil)
      return has_any_inline_policies? unless policy_name

      res = iam_client.get_role_policy({
                                         role_name: resource_via_client.role_name,
                                         policy_name: policy_name
                                       })
      return JSON.parse(URI.decode(res.policy_document)) == JSON.parse(document) if document
      res
    end

    private

    def has_any_inline_policies?
      res = iam_client.list_role_policies(role_name: resource_via_client.role_name)
      !res.policy_names.empty?
    end
  end
end
