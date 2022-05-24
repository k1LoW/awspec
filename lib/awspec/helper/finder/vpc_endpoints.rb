# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module VpcEndpoints
      def find_vpc_endpoint(id)
        res = ec2_client.describe_vpc_endpoints({
                                                  filters: [{ name: 'vpc-endpoint-id', values: [id] }]
                                                })

        ret = res.vpc_endpoints.select do |vpce|
          vpce.vpc_endpoint_id == id
        end

        resource = ret.single_resource(id)
        return resource if resource

        res = ec2_client.describe_vpc_endpoints({
                                                  filters: [{ name: 'tag:Name', values: [id] }]
                                                })

        ret = res.vpc_endpoints.select do |vpce|
          vpce.tags.find do |tag|
            tag.key == 'Name' && tag.value == id
          end
        end

        ret.single_resource(id)
      end
    end
  end
end
