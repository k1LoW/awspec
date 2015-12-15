module Awspec::Helper
  module Finder
    module SecurityGroup
      def find_security_group(id)
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'group-id', values: [id] }]
                                                  })

        return res[:security_groups].first if res[:security_groups].count == 1
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'group-name', values: [id] }]
                                                  })

        return res[:security_groups].first if res[:security_groups].count == 1
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'tag:Name', values: [id] }]
                                                  })

        return res[:security_groups].first if res[:security_groups].count == 1
      end

      def select_security_group_by_vpc_id(vpc_id)
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                                  })
        res[:security_groups]
      end
    end
  end
end
