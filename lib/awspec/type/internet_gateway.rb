module Awspec::Type
  class InternetGateway < ResourceBase
    aws_resource Aws::EC2::InternetGateway
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_internet_gateway(@display_name)
    end

    def id
      @id ||= resource_via_client.internet_gateway_id if resource_via_client
    end

    def attached_to?(vpc)
      resource_via_client.attachments.find do |a|
        a.vpc_id == find_vpc(vpc).vpc_id && a.state == 'available'
      end
    end
  end
end
