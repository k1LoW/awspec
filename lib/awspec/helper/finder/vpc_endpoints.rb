module Awspec::Helper
  module Finder
    module VpcEndpoints
      def find_vpc_endpoint(id)
        res = ec2_client.describe_vpc_endpoints({
                                         filters: [{ name: 'vpc-endpoint-id', values: [id] }]
                                       })
        resource = res.vpc_endpoints.single_resource(id)
      end
    end
  end
end
