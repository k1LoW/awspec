module Awspec::Helper
  module Finder
    module InternetGateway
      def find_internet_gateway(id)
        res = ec2_client.describe_internet_gateways({
                                                      internet_gateway_ids: [id]
                                                    })
        resource = res.internet_gateways.single_resource(id)
        return resource if resource
        res = ec2_client.describe_internet_gateways({
                                                      filters: [{ name: 'tag:Name', values: [id] }]
                                                    })
        resource = res.internet_gateways.single_resource(id)
        return resource if resource
        res = ec2_client.describe_internet_gateways({
                                                      filters: [{ name: 'vpc_id', values: [id] }]
                                                    })
        resource = res.internet_gateways.single_resource(id)
      end
    end
  end
end
