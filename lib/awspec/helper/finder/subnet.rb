module Awspec::Helper
  module Finder
    module Subnet
      def find_subnet(subnet_id)
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'subnet-id', values: [subnet_id] }]
                                          })
        resource = res.subnets.single_resource(subnet_id)
        return resource if resource
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'tag:Name', values: [subnet_id] }]
                                          })
        resource = res.subnets.single_resource(subnet_id)
        return resource if resource
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'cidrBlock', values: [subnet_id] }]
                                          })
        res.subnets.single_resource(subnet_id)
      end

      def select_subnet_by_vpc_id(vpc_id)
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                          })
        res.subnets
      end
    end
  end
end
