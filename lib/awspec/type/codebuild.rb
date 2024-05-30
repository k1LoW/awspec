# frozen_string_literal: true

module Awspec::Type
  class Codebuild < ResourceBase
    aws_resource Aws::CodeBuild::Types::Project
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_codebuild_project(@display_name)
    end

    def id
      @id ||= resource_via_client if resource_via_client
    end
  end
end
