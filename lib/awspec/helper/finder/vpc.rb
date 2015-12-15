module Awspec::Helper
  module Finder
    module Vpc
      def find_vpc(id)
        res = ec2_client.describe_vpcs({
                                         filters: [{ name: 'vpc-id', values: [id] }]
                                       })
        return res[:vpcs].first if res[:vpcs].count == 1
        res = ec2_client.describe_vpcs({
                                         filters: [{ name: 'tag:Name', values: [id] }]
                                       })
        return res[:vpcs].first if res[:vpcs].count == 1
      end

      def find_route_table(route_table_id)
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'route-table-id', values: [route_table_id] }]
                                               })
        return res[:route_tables].first if res[:route_tables].count == 1
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'tag:Name', values: [route_table_id] }]
                                               })
        return res[:route_tables].first if res[:route_tables].count == 1
      end

      def find_network_acl(id)
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'network-acl-id', values: [id] }]
                                               })
        return res[:network_acls].first if res[:network_acls].count == 1
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'tag:Name', values: [id] }]
                                               })
        return res[:network_acls].first if res[:network_acls].count == 1
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

      def find_subnet(subnet_id)
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'subnet-id', values: [subnet_id] }]
                                          })
        return res[:subnets].first if res[:subnets].count == 1
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'tag:Name', values: [subnet_id] }]
                                          })
        return res[:subnets].first if res[:subnets].count == 1
      end

      def select_subnet_by_vpc_id(vpc_id)
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                          })
        res[:subnets]
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
        return res[:vpc_peering_connections].first if res[:vpc_peering_connections].count == 1
        res = ec2_client.describe_vpc_peering_connections({
                                                            filters: [
                                                              {
                                                                name: 'tag:Name',
                                                                values: [vpc_peering_connection_id]
                                                              }
                                                            ]
                                                          })
        return res[:vpc_peering_connections].first if res[:vpc_peering_connections].count == 1
      end
    end
  end
end
