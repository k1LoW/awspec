module Awspec::Type
  class RouteTable < Base
    def initialize(id)
      super
      @resource = find_route_table(id)
      @id = @resource[:route_table_id] if @resource
    end

    def has_route?(target, destination = nil)
      @resource.routes.find do |route|
        if destination
          next false unless route.destination_cidr_block == destination
        end
        next true if route.gateway_id == target
        igw = find_internet_gateway(target)
        next true if igw.internet_gateway_id == target || igw.tag_name == target
      end
    end
  end
end
