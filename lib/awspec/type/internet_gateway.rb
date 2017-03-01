module Awspec::Type
  class InternetGateway < Base
    aws_resource Aws::EC2::InternetGateway
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_internet_gateway(@display_name)
    end

    def id
      @id ||= resource_via_client.internet_gateway_id if resource_via_client
    end

    def attached_to?(vpc_id)
      resource_via_client.attachments.first.vpc_id == vpc_id && \
        resource_via_client.attachments.first.state == 'attached'
    end
  end
end
