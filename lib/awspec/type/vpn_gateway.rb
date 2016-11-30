module Awspec::Type
  class VpnGateway < Base
    tags_allowed

    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_vpn_gateway(@display_name)
    end

    def id
      @id ||= resource_via_client.vpn_gateway_id if resource_via_client
    end

    STATES = %w(
      pending available deleting deleted
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.state == state
      end
    end

    def availability_zone
      resource_via_client.availability_zone
    end

    def vpc_attachments
      resource_via_client.vpc_attachments
    end

    def type
      resource_via_client.type
    end
  end
end
