# frozen_string_literal: true

module Awspec::Type
  class CloudformationStack < ResourceBase
    aws_resource Aws::CloudFormation::Stack
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_cloudformation_stack(@display_name)
    end

    def id
      @id ||= resource_via_client.stack_name if resource_via_client
    end
  end
end
