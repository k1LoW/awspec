module Awspec::Helper
  module Finder
    module Vpc
      def find_vpc(id)
        res = @ec2_client.describe_vpcs({
                                          filters: [{ name: 'vpc-id', values: [id] }]
                                        })
        return res[:vpcs][0] if res[:vpcs].count == 1
        res = @ec2_client.describe_vpcs({
                                          filters: [{ name: 'tag:Name', values: [id] }]
                                        })
        return res[:vpcs][0] if res[:vpcs].count == 1
      end

      def find_route_table(id)
        res = @ec2_client.describe_route_tables({
                                                  filters: [{ name: 'route-table-id', values: [id] }]
                                                })
        return res[:route_tables][0] if res[:route_tables].count == 1
        res = @ec2_client.describe_route_tables({
                                                  filters: [{ name: 'tag:Name', values: [id] }]
                                                })
        return res[:route_tables][0] if res[:route_tables].count == 1
      end

      def find_network_acl(id)
        res = @ec2_client.describe_network_acls({
                                                  filters: [{ name: 'network-acl-id', values: [id] }]
                                                })
        return res[:network_acls][0] if res[:network_acls].count == 1
        res = @ec2_client.describe_network_acls({
                                                  filters: [{ name: 'tag:Name', values: [id] }]
                                                })
        return res[:network_acls][0] if res[:network_acls].count == 1
      end
    end
  end
end
