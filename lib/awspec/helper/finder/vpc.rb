module Awspec::Helper
  module Finder
    module Vpc
      def find_vpc(id)
        res = ec2_client.describe_vpcs({
                                         filters: [{ name: 'vpc-id', values: [id] }]
                                       })
        if res[:vpcs].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{id}"
        end
        return res[:vpcs].first if res[:vpcs].count == 1
        res = ec2_client.describe_vpcs({
                                         filters: [{ name: 'tag:Name', values: [id] }]
                                       })
        if res[:vpcs].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{id}"
        end
        res[:vpcs].first if res[:vpcs].count == 1
      end

      def find_route_table(route_table_id)
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'route-table-id', values: [route_table_id] }]
                                               })
        if res[:route_tables].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{route_table_id}"
        end
        return res[:route_tables].first if res[:route_tables].count == 1
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'tag:Name', values: [route_table_id] }]
                                               })
        if res[:route_tables].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{route_table_id}"
        end
        res[:route_tables].first if res[:route_tables].count == 1
      end

      def find_network_acl(id)
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'network-acl-id', values: [id] }]
                                               })
        if res[:network_acls].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{id}"
        end
        return res[:network_acls].first if res[:network_acls].count == 1
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'tag:Name', values: [id] }]
                                               })
        if res[:network_acls].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{id}"
        end
        res[:network_acls].first if res[:network_acls].count == 1
      end

      def select_route_table_by_vpc_id(vpc_id)
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                               })
        res[:route_tables]
      end

      def select_network_acl_by_vpc_id(vpc_id)
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                               })
        res[:network_acls]
      end

      def find_vpc_peering_connection(vpc_peering_connection_id)
        res = ec2_client.describe_vpc_peering_connections({
                                                            filters: [
                                                              {
                                                                name: 'vpc-peering-connection-id',
                                                                values: [vpc_peering_connection_id]
                                                              }
                                                            ]
                                                          })
        if res[:vpc_peering_connections].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{vpc_peering_connection_id}"
        end
        return res[:vpc_peering_connections].first if res[:vpc_peering_connections].count == 1
        res = ec2_client.describe_vpc_peering_connections({
                                                            filters: [
                                                              {
                                                                name: 'tag:Name',
                                                                values: [vpc_peering_connection_id]
                                                              }
                                                            ]
                                                          })
        if res[:vpc_peering_connections].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{vpc_peering_connection_id}"
        end
        res[:vpc_peering_connections].first if res[:vpc_peering_connections].count == 1
      end
    end
  end
end
