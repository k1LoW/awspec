module Awspec::Helper
  module Finder
    module SecurityGroup
      def find_security_group(sg_id)
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'group-id', values: [sg_id] }]
                                                  })
        resource = res.security_groups.single_resource(sg_id)
        return resource if resource
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'group-name', values: [sg_id] }]
                                                  })
        resource = res.security_groups.single_resource(sg_id)
        return resource if resource
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'tag:Name', values: [sg_id] }]
                                                  })
        res.security_groups.single_resource(sg_id)
      end

      def select_security_group_by_vpc_id(vpc_id)
        res = ec2_client.describe_security_groups({
                                                    filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                                  })
        res.security_groups
      end
    end
  end
end
