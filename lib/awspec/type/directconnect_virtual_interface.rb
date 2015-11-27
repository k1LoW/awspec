module Awspec::Type
  class DirectconnectVirtualInterface < Base
    def initialize(id)
      super
      @resource = find_virtual_interface(id)
      @id = @resource[:virtual_interface_id] if @resource
    end

    STATES = %w(
      confirming verifying pending available
      deleting deleted rejected
    )

    STATES.each do |state|
      define_method state + '?' do
        @resource[:virtual_interface_state] == state
      end
    end
  end
end
