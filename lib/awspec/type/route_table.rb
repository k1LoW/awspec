module Awspec::Type
  class RouteTable < Base
    def initialize(id)
      super
      @resource = find_route_table(id)
      @id = @resource[:route_table_id] if @resource
    end

    def has_route?(destination, gateway_id = nil, instance_id = nil)
      @resource.routes.find do |route|
        if destination
          next false unless route.destination_cidr_block == destination
        end
        # * gateway
        next true if route.gateway_id == gateway_id
        # internet gateway
        igw = find_internet_gateway(gateway_id)
        next true if igw && igw.tag_name == gateway_id
        # virtual gateway
        vgw = find_virtual_gateway(gateway_id)
        next true if vgw && vgw.tag_name == gateway_id
        # customer gateway
        cgw = find_customer_gateway(gateway_id)
        next true if cgw && cgw.tag_name == gateway_id
        # instance
        next true if route.instance_id == instance_id
        instance = find_ec2(instance_id)
        next true if instance && instance.tag_name == instance_id
      end
    end

    def has_subnet?(subnet_id)
      subnet = find_subnet(subnet_id)
      return false unless subnet
      @resource.associations.find do |a|
        a[:subnet_id] == subnet[:subnet_id]
      end
    end
  end
end
