module Awspec::Type
  class VpnConnection < ResourceBase
    tags_allowed

    def initialize(name, params = nil)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_vpn_connection(@display_name)
    end

    def id
      @id ||= resource_via_client.vpn_connection_id if resource_via_client
    end

    STATES = %w(
      pending available deleting deleted
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.state == state
      end
    end

    def customer_gateway_id
      resource_via_client.customer_gateway_id
    end

    def vpn_gateway_id
      resource_via_client.vpn_gateway_id
    end

    def type
      resource_via_client.type
    end
  end
end
