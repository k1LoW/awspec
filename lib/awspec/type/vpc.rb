module Awspec::Type
  class Vpc < Base
    attr_reader :client

    def initialize(id)
      super
      @client = @ec2_client
      @resource = find_vpc(id)
      @id = @resource[:vpc_id] if @resource
    end

    states = %w(
      available pending
    )

    states.each do |state|
      define_method state + '?' do
        @resource[:state] == state
      end
    end

    def has_route_table?(id)
      route_table = find_route_table(id)
      return false unless route_table
      route_table[:vpc_id] == @id
    end

    def has_network_acl?(id)
      n = find_network_acl(id)
      return false unless n
      n[:vpc_id] == @id
    end
  end
end
