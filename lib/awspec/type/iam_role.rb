module Awspec::Type
  class IamRole < ResourceBase
    aws_resource Aws::IAM::Role

    def resource_via_client
      @resource_via_client ||= find_iam_role(@display_name)
    end

    def id
      @id ||= resource_via_client.role_id if resource_via_client
    end

    def has_iam_policy?(policy_id)
      policies = select_iam_policy_by_role_name(resource_via_client.role_name)
      policies.find do |policy|
        policy.policy_arn == policy_id || policy.policy_name == policy_id
      end
    end

    def has_inline_policy?(policy_name, document = nil)
      res = iam_client.get_role_policy({
                                         role_name: resource_via_client.role_name,
                                         policy_name: policy_name
                                       })
      return JSON.parse(URI.decode(res.policy_document)) == JSON.parse(document) if document
      res
    end
  end
end
