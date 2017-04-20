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
      return false unless res[:route_tables].length == 1
      route_table = res[:route_tables][0]

      name_tag = route_table.tags.select { |tag| tag.key == 'Name' }
      name = name_tag.nil? ? nil : name_tag[0].value

      route_table.route_table_id == route_table_id || name == route_table_id
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
