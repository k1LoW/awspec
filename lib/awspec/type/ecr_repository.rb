module Awspec::Type
  class EcrRepository < ResourceBase
    aws_resource Aws::ECR::Types::Repository

    def resource_via_client
      @resource_via_client ||= find_ecr_repository(@display_name)
    end

    def id
      @id ||= resource_via_client.repository_name if resource_via_client
    end
  end
end
