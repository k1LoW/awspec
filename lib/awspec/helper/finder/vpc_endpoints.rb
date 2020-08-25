module Awspec::Helper
  module Finder
    module VpcEndpoints
      def find_vpc_endpoint(id)
        res = ec2_client.describe_vpc_endpoints({ vpc_endpoint_ids: [id] })

        ret = res.vpc_endpoints.select do |vpce|
          vpce.vpc_endpoint_id == id
        end

        ret.single_resource(id)
      end
    end
  end
end
