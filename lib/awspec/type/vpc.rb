module Awspec::Type
  class Vpc < ResourceBase
    aws_resource Aws::EC2::Vpc
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_vpc(@display_name)
    end

    def id
      @id ||= resource_via_client.vpc_id if resource_via_client
    end

    STATES = %w(
      available pending
    )

    STATES.each do |state|
      define_method state + '?' do
        resource_via_client.state == state
      end
    end

    def has_route_table?(table_id)
      route_table = find_route_table(table_id)
      return false unless route_table
      route_table.vpc_id == id
    end

    def has_network_acl?(table_id)
      n = find_network_acl(table_id)
      return false unless n
      n.vpc_id == id
    end

    def connected_to_vpc?(vpc_id, accepter_or_requester = nil)
      connections = select_vpc_peering_connection_by_vpc_id(vpc_id, 'active')
      return connections.single_resource(vpc_id) unless accepter_or_requester

      if accepter_or_requester == 'accepter'
        connections.select do |conn|
          conn.accepter_vpc_info.vpc_id == @id
        end.single_resource(vpc_id)
      elsif accepter_or_requester == 'requester'
        connections.select do |conn|
          conn.requester_vpc_info.vpc_id == @id
        end.single_resource(vpc_id)
      end
    end

    def has_vpc_peering_connection?(vpc_peering_connection_id, accepter_or_requester = nil)
      connection = find_vpc_peering_connection(vpc_peering_connection_id)
      res = if accepter_or_requester == 'accepter'
              connection.accepter_vpc_info.vpc_id == @id
            elsif accepter_or_requester == 'requester'
              connection.requester_vpc_info.vpc_id == @id
            else
              connection
            end
    end

    def has_vpc_attribute?(vpc_attribute)
      find_vpc_attribute(resource_via_client.vpc_id, vpc_attribute)
    end
  end
end
