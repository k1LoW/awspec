# frozen_string_literal: true

module Awspec::Type
  class Wafv2IpSet < ResourceBase
    attr_accessor :scope

    def resource_via_client
      @resource_via_client ||= find_ip_set(scope, @display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    def scope
      @scope || 'REGIONAL'
    end

    def has_ip_address?(ip_address)
      resource_via_client.addresses.include?(ip_address)
    end
  end
end
