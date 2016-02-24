module Awspec::Helper
  module Finder
    module SecurityGroup
      def find_security_group(sg_id)
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'group-id', values: [sg_id] }]
                                                  })
        if res[:security_groups].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{sg_id}"
        end
        return res[:security_groups].first if res[:security_groups].count == 1
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'group-name', values: [sg_id] }]
                                                  })
        if res[:security_groups].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{sg_id}"
        end
        return res[:security_groups].first if res[:security_groups].count == 1
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'tag:Name', values: [sg_id] }]
                                                  })
        if res[:security_groups].count > 1
          raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{sg_id}"
        end
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
