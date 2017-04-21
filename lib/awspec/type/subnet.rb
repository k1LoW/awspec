module Awspec::Type
  class Subnet < ResourceBase
    aws_resource Aws::EC2::Subnet
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_subnet(@display_name)
    end

    def id
      @id ||= resource_via_client.subnet_id if resource_via_client
    end

    def associated_to?(route_table_id)
      res = ec2_client.describe_route_tables({
                                               filters:
                                               [
                                                 {
                                                   name: 'association.subnet-id',
                                                   values: [id]
                                                 }
                                               ]
                                             })
      return false if res[:route_tables].empty?
      associated_route_table = res[:route_tables].first
      associated_route_table.route_table_id == route_table_id || associated_route_table.tag_name == route_table_id
    end

    STATES = %w(
      available pending
    )

    STATES.each do |state|
      define_method state + '?' do
        resource_via_client.state == state
      end
    end
  end
end
