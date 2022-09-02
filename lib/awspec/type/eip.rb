# frozen_string_literal: true

module Awspec::Type
  class Eip < ResourceBase
    aws_resource Aws::EC2::Types::Address

    def resource_via_client
      @resource_via_client ||= select_eip(@display_name)
    end

    def id
      @id ||= resource_via_client.public_ip if resource_via_client
    end

    def associated_to?(instance_id)
      return false unless resource_via_client.instance_id == instance_id

      resource_via_client.instance_id == instance_id
    end
  end
end
