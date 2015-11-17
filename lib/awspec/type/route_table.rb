module Awspec::Type
  class RouteTable < Base
    def initialize(id)
      super
      @resource = find_route_table(id)
      @id = @resource[:route_table_id] if @resource
    end

    def has_route?(destination, gateway_id = nil, instance_id = nil, vpc_peering_connection_id = nil)
      @resource.routes.find do |route|
        if destination
          next false unless route.destination_cidr_block == destination
        end
        next target_gateway?(route, gateway_id) if gateway_id
        next target_instance?(route, instance_id) if instance_id
        next target_vpc_peering_connection?(route, vpc_peering_connection_id) if vpc_peering_connection_id
      end
    end

    def has_subnet?(subnet_id)
      subnet = find_subnet(subnet_id)
      return false unless subnet
      @resource.associations.find do |a|
        a[:subnet_id] == subnet[:subnet_id]
      end
    end

    private

    def target_gateway?(route, gateway_id)
      # * gateway
      return true if route.gateway_id == gateway_id
      # internet gateway
      igw = find_internet_gateway(gateway_id)
      return true if igw && igw.tag_name == gateway_id
      # vpn gateway
      vgw = find_vpn_gateway(gateway_id)
      return true if vgw && vgw.tag_name == gateway_id
      # customer gateway
      cgw = find_customer_gateway(gateway_id)
      return true if cgw && cgw.tag_name == gateway_id
      false
    end

    def target_instance?(route, instance_id)
      # instance
      return true if route.instance_id == instance_id
      instance = find_ec2(instance_id)
      return true if instance && instance.tag_name == instance_id
      false
    end

    def target_vpc_peering_connection?(route, vpc_peering_connection_id)
      # vpc_peering_connection_id
      return true if route.vpc_peering_connection_id == vpc_peering_connection_id
      connection = find_vpc_peering_connection(vpc_peering_connection_id)
      return true if connection && connection.tag_name == vpc_peering_connection_id
      false
    end
  end
end
