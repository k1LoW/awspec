module Awspec::Type
  class Subnet < Resource
    aws_resource Aws::EC2::Subnet
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_subnet(@display_name)
    end

    def id
      @id ||= resource_via_client.subnet_id if resource_via_client
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
