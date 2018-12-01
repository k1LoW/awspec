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

      def find_route_table(route_table_id)
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'route-table-id', values: [route_table_id] }]
                                               })
        resource = res.route_tables.single_resource(route_table_id)
        return resource if resource
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'tag:Name', values: [route_table_id] }]
                                               })
        res.route_tables.single_resource(route_table_id)
      end

      def find_network_acl(id)
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'network-acl-id', values: [id] }]
                                               })
        resource = res.network_acls.single_resource(id)
        return resource if resource
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'tag:Name', values: [id] }]
                                               })
        res.network_acls.single_resource(id)
      end

      def select_route_table_by_vpc_id(vpc_id)
        res = ec2_client.describe_route_tables({
                                                 filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                               })
        res.route_tables
      end

      def select_network_acl_by_vpc_id(vpc_id)
        res = ec2_client.describe_network_acls({
                                                 filters: [{ name: 'vpc-id', values: [vpc_id] }]
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

      def select_vpc_peering_connection_by_vpc_id(vpc_id, status_code = nil)
        params = {}
        params = { filters: [{ name: 'status-code', values: [status_code] }] } if status_code
        vpc_peering_connections = ec2_client.describe_vpc_peering_connections(params).map do |res|
          res.vpc_peering_connections
        end.flatten
        vpc_peering_connections.select do |conn|
          conn.accepter_vpc_info.vpc_id == vpc_id || conn.requester_vpc_info.vpc_id == vpc_id
        end
      end

      def find_vpc_attribute(vpc_id, vpc_attribute)
        res = ec2_client.describe_vpc_attribute({ vpc_id: vpc_id, attribute: vpc_attribute })
        case vpc_attribute
        when 'enableDnsSupport' then
          res.enable_dns_support.value
        when 'enableDnsHostnames' then
          res.enable_dns_hostnames.value
        end
      end

      def select_vpc_attribute(vpc_id)
        attributes = {}
        vpc_attributes = %w(
          enableDnsHostnames enableDnsSupport
        )
        vpc_attributes.each do |vpc_attribute|
          res = ec2_client.describe_vpc_attribute({ vpc_id: vpc_id, attribute: vpc_attribute })
          attributes[vpc_attribute] = case vpc_attribute
                                      when 'enableDnsHostnames' then
                                        res.enable_dns_hostnames.value
                                      when 'enableDnsSupport' then
                                        res.enable_dns_support.value
                                      end
        end
        attributes
      end
    end
  end
end
