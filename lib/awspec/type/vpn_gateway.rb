# frozen_string_literal: true

module Awspec::Type
  class VpnGateway < ResourceBase
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

    STATES = %w[
      pending available deleting deleted
    ]

    STATES.each do |state|
      define_method "#{state.tr('-', '_')}?" do
        resource_via_client.state == state
      end
    end

    def vpc_id
      resource_via_client.vpc_attachments.first.vpc_id
    end
  end
end
