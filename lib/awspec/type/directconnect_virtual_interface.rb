module Awspec::Type
  class DirectconnectVirtualInterface < Base
    def initialize(id)
      super
      @resource = find_virtual_interface(id)
      @id = @resource[:virtual_interface_id] if @resource
    end

    states = %w(
      confirming verifying pending available
      deleting deleted rejected
    )

    states.each do |state|
      define_method state + '?' do
        @resource[:virtual_interface_state] == state
      end
    end
  end
end
