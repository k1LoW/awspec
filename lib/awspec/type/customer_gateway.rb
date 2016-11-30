module Awspec::Type
  class CustomerGateway < Base
    tags_allowed

    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_customer_gateway(@display_name)
    end

    def id
      @id ||= resource_via_client.customer_gateway_id if resource_via_client
    end

    STATES = %w(
      pending available deleting deleted
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.state == state
      end
    end

    def ip_address
      resource_via_client.ip_address
    end

    def bpg_asn
      resource_via_client.bpg_asn
    end

    def type
      resource_via_client.type
    end
  end
end
