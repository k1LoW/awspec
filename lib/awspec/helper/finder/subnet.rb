module Awspec::Helper
  module Finder
    module Subnet
      def find_subnet(subnet_id)
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'subnet-id', values: [subnet_id] }]
                                          })
        if res[:subnets].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{subnet_id}"
        end
        return res[:subnets].first if res[:subnets].count == 1
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'tag:Name', values: [subnet_id] }]
                                          })
        if res[:subnets].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{subnet_id}"
        end
        res[:subnets].first if res[:subnets].count == 1
      end

      def select_subnet_by_vpc_id(vpc_id)
        res = ec2_client.describe_subnets({
                                            filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                          })
        res[:subnets]
      end
    end
  end
end
