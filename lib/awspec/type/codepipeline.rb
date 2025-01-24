# frozen_string_literal: true

module Awspec::Type
  class Codepipeline < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_codepipeline(@display_name)
    end

    def id
      @id ||= resource_via_client if resource_via_client.name
    end
  end
end
