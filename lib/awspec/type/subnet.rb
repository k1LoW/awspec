module Awspec::Type
  class Subnet < Base
    aws_resource Aws::EC2::Subnet
    tags_allowed

    def initialize(id)
      super
      @resource_via_client = find_subnet(id)
      @id = @resource_via_client.subnet_id if @resource_via_client
    end

    STATES = %w(
      available pending
    )

    STATES.each do |state|
      define_method state + '?' do
        @resource_via_client.state == state
      end
    end
  end
end
