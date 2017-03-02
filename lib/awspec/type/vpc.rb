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
  end
end
