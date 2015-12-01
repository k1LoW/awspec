module Awspec::Type
  class Subnet < Base
    def initialize(id)
      super
      @resource = find_subnet(id)
      @id = @resource[:subnet_id] if @resource
    end

    STATES = %w(
      available pending
    )

    STATES.each do |state|
      define_method state + '?' do
        @resource[:state] == state
      end
    end
  end
end
