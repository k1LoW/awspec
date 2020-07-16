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
      atts = find_tgw_attachments_by_tgw_id(@id)
      ret = atts.find_all { |att| att.transit_gateway_attachment_id == att_id }
      ret.any?
    end
  end
end
