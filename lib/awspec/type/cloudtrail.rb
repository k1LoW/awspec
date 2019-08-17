module Awspec::Type
  class Cloudtrail < ResourceBase
    aws_resource Aws::CloudTrail

    def resource_via_client
      @resource_via_client ||= find_trail(@display_name)
    end

    def id
      @id ||= resource_via_client.name if resource_via_client
    end

    def has_global_service_events_included?
      resource_via_client.include_global_service_events
    end

    def multi_region_trail?
      resource_via_client.is_multi_region_trail
    end

    def has_log_file_validation_enabled?
      resource_via_client.log_file_validation_enabled
    end

    def logging?
      is_logging?(id)
    end

    def has_tag?(tag_key, tag_value)
      get_trail_tags(resource_via_client.trail_arn).find do |tag|
        tag.key == tag_key && tag.value == tag_value
      end
    end
  end
end
