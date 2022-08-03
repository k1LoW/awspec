# frozen_string_literal: true

module Awspec::Type
  class RdsDbSubnetGroup < ResourceBase
    aws_resource Aws::RDS::Types::DBSubnetGroup

    def resource_via_client
      @resource_via_client ||= find_db_subnet_group(@display_name)
    end

    def id
      @id ||= resource_via_client.db_subnet_group_name if resource_via_client
    end

    def vpc_id
      resource_via_client.vpc_id
    end
  end
end
