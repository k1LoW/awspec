module Awspec::Type
  class DirectconnectVirtualInterface < Base
    def initialize(id)
      super
      @resource_via_client = find_virtual_interface(id)
      @id = @resource_via_client[:virtual_interface_id] if @resource_via_client
    end

    STATES = %w(
      confirming verifying pending available
      deleting deleted rejected
    )

    STATES.each do |state|
      define_method state + '?' do
        @resource_via_client[:virtual_interface_state] == state
      end
    end
  end
end
