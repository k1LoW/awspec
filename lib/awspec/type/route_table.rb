module Awspec::Type
  class RouteTable < ResourceBase
    aws_resource Aws::EC2::RouteTable
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_route_table(@display_name)
    end

    def id
      @id ||= resource_via_client.route_table_id if resource_via_client
    end

    def has_route?(destination,
                   gateway_id = nil,
                   instance_id = nil,
                   vpc_peering_connection_id = nil,
                   nat_gateway_id = nil)
      resource_via_client.routes.find do |route|
        if destination
          next false unless [route.destination_cidr_block, route.destination_prefix_list_id].include?(destination)
        end
        next target_gateway?(route, gateway_id) if gateway_id
        next target_instance?(route, instance_id) if instance_id
        next target_vpc_peering_connection?(route, vpc_peering_connection_id) if vpc_peering_connection_id
        next target_nat?(route, nat_gateway_id) if nat_gateway_id
      end
    end

    def has_subnet?(subnet_id)
      subnet = find_subnet(subnet_id)
      return false unless subnet
      resource_via_client.associations.find do |a|
        a.subnet_id == subnet.subnet_id
      end
    end

    def route_count
      resource_via_client.routes.count
    end

    private

    def target_gateway?(route, gateway_id)
      # * gateway
      return true if route.gateway_id == gateway_id
      # internet gateway
      igw = find_internet_gateway(gateway_id)
      return true if igw && igw.internet_gateway_id == route.gateway_id
      # vpn gateway
      vgw = find_vpn_gateway(gateway_id)
      return true if vgw && vgw.vpn_gateway_id == route.gateway_id
      # customer gateway
      cgw = find_customer_gateway(gateway_id)
      return true if cgw && cgw.customer_gateway_id == route.gateway_id
      # nat gateway
      nat = find_nat_gateway(gateway_id)
      return true if nat.nat_gateway_id == route.nat_gateway_id
      false
    end

    def target_instance?(route, instance_id)
      # instance
      return true if route.instance_id == instance_id
      instance = find_ec2(instance_id)
      return true if instance && instance.instance_id == route.instance_id
      false
    end

    def target_nat?(route, nat_gateway_id)
      # nat
      nat = find_nat_gateway(nat_gateway_id)
      nat.nat_gateway_id == route.nat_gateway_id
    end

    def target_vpc_peering_connection?(route, vpc_peering_connection_id)
      # vpc_peering_connection_id
      return true if route.vpc_peering_connection_id == vpc_peering_connection_id
      connection = find_vpc_peering_connection(vpc_peering_connection_id)
      return true if connection && connection.vpc_peering_connection_id == route.vpc_peering_connection_id
      false
    end
  end
end
