module Awspec::Type
  class RouteTable < Base
    attr_reader :route_table

    def initialize(id)
      super
      @route_table = find_route_table(id)
      @id = @route_table[:route_table_id] if @route_table
    end

    def has_route?(target, destination = nil)
      @route_table.routes.find do |route|
        if destination
          next false unless route.destination_cidr_block == destination
        end
        next true if route.gateway_id == target
        igw = find_internet_gateway(target)
        next true if igw.internet_gateway_id == target || igw.tag_name == target
      end
    end

    def method_missing(name)
      describe = name.to_sym
      if @route_table.members.include?(describe)
        @route_table[describe]
      else
        super
      end
    end
  end
end
