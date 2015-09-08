module Awspec::Type
  class Subnet < Base
    def initialize(id)
      super
      @resource = find_subnet(id)
      @id = @resource[:subnet_id] if @resource
    end

    states = %w(
      available pending
    )

    states.each do |state|
      define_method state + '?' do
        @resource[:state] == state
      end
    end
  end
end
