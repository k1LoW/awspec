module Awspec::Helper
  module Finder
    module Vpc
      def find_vpc(id)
        res = ec2_client.describe_vpcs({
                                         filters: [{ name: 'vpc-id', values: [id] }]
                                       })
        resource = res.vpcs.single_resource(id)
        return resource if resource
        res = ec2_client.describe_vpcs({
                                         filters: [{ name: 'tag:Name', values: [id] }]
                                       })
        res.vpcs.single_resource(id)
      end

      def vpc_id_filter(vpc_id)
        vpc_id.nil? ? [] : [{ name: 'vpc-id', values: [vpc_id] }]
      end

      def find_route_table(route_table_id, vpc_id = nil)
        res = ec2_client.describe_route_tables({
                                                 filters: vpc_id_filter(vpc_id) +
                                                  [{ name: 'route-table-id', values: [route_table_id] }]
                                               })
        resource = res.route_tables.single_resource(route_table_id)
        return resource if resource
        res = ec2_client.describe_route_tables({
                                                 filters: vpc_id_filter(vpc_id) +
                                                  [{ name: 'tag:Name', values: [route_table_id] }]
                                               })
        res.route_tables.single_resource(route_table_id)
      end

      def find_network_acl(id, vpc_id = nil)
        res = ec2_client.describe_network_acls({
                                                 filters: vpc_id_filter(vpc_id) +
                                                  [{ name: 'network-acl-id', values: [id] }]
                                               })
        resource = res.network_acls.single_resource(id)
        return resource if resource
        res = ec2_client.describe_network_acls({
                                                 filters: vpc_id_filter(vpc_id) +
                                                  [{ name: 'tag:Name', values: [id] }]
                                               })
        res.network_acls.single_resource(id)
      end

      def select_route_table_by_vpc_id(vpc_id)
        res = ec2_client.describe_route_tables({
                                                 filters: vpc_id_filter(vpc_id)
                                               })
        res.route_tables
      end

      def select_network_acl_by_vpc_id(vpc_id)
        res = ec2_client.describe_network_acls({
                                                 filters: vpc_id_filter(vpc_id)
                                               })
        res.network_acls
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
        resource = res.vpc_peering_connections.single_resource(vpc_peering_connection_id)
        return resource if resource
        res = ec2_client.describe_vpc_peering_connections({
                                                            filters: [
                                                              {
                                                                name: 'tag:Name',
                                                                values: [vpc_peering_connection_id]
                                                              }
                                                            ]
                                                          })
        res.vpc_peering_connections.single_resource(vpc_peering_connection_id)
      end
    end
  end
end
