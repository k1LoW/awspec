module Awspec::Type
  class Efs < ResourceBase
    def initialize(file_system_id)
      super
      @display_name = file_system_id
    end

    def resource_via_client
      @resource_via_client ||= find_efs(@display_name)
    end

    def id
      @id ||= resource_via_client.file_system_id if resource_via_client
    end

    def has_tag?(tag_key, tag_value)
      tag = find_efs_tags(@display_name, tag_key)
      return nil if tag.value != tag_value
      tag
    end
  end
end
