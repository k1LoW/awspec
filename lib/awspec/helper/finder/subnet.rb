module Awspec::Helper
  module Finder
    module Subnet
      def filter_type_matcher(search_key)
        deafult = 'tag:Name'
        case search_key
        when /subnet-[a-zA-Z0-9]{8}/
          return 'subnet-id'
        when %r{[1-9][0-9]{1,2}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}//[0-9]{1,3}}
          return 'cidrBlock'
        else
          return deafult
        end
      end

      def find_subnet(search_key)
        res = ec2_client.describe_subnets({
                                            filters: [{ name: filter_type_matcher(search_key), values: [search_key] }]
                                          })
        res.subnets.single_resource(search_key)
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
