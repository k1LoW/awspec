module Awspec::Type
  class DirectconnectVirtualInterface < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_virtual_interface(@display_name)
    end

    def id
      @id ||= resource_via_client.virtual_interface_id if resource_via_client
    end

    STATES = %w(
      confirming verifying pending available
      deleting deleted rejected
    )

    STATES.each do |state|
      define_method state + '?' do
        resource_via_client.virtual_interface_state == state
      end
    end
  end
end
