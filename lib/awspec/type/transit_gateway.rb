# frozen_string_literal: true

module Awspec::Type
  class TransitGateway < ResourceBase
    aws_resource Aws::EC2::Types::TransitGateway
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_transit_gateway(@display_name)
    end

    def id
      @id ||= resource_via_client.transit_gateway_id if resource_via_client
    end

    def options
      resource_via_client.options
    end

    def has_attachment?(att_id)
      atts = find_tgw_attachments_by_tgw_id(id)

      atts.any? do |att|
        att.transit_gateway_attachment_id == att_id || attachment_has_name?(att, att_id)
      end
    end

    private

    def attachment_has_name?(attachment, name)
      if name.is_a?(Regexp)
        attachment.tags.any? { |tag| tag.key == 'Name' && (name =~ tag.value) }
      else
        attachment.tags.any? { |tag| tag.key == 'Name' && tag.value == name }
      end
    end
  end
end
