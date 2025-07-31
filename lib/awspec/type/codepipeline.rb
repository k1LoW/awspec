# frozen_string_literal: true

module Awspec::Type
  class Codepipeline < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_codepipeline(@display_name)
    end

    def id
      @id ||= resource_via_client.name if resource_via_client
    end
  end
end
