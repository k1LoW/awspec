module Awspec::Helper
  module Finder
    module SecurityGroup
      def find_security_group(sg_id)
        resource = select_security_group_by_group_id([sg_id]).single_resource(sg_id)
        return resource if resource

        resource = select_security_group_by_group_name([sg_id]).single_resource(sg_id)
        return resource if resource

        select_security_group_by_tag_name([sg_id]).single_resource(sg_id)
      end

      def select_security_group_by_vpc_id(vpc_id)
        describe_security_groups({ filters: [{ name: 'vpc-id', values: [vpc_id] }] })
      end

      def select_security_group_by_group_id(ids)
        describe_security_groups({ filters: [{ name: 'group-id', values: ids }] })
      end

      def select_security_group_by_group_name(names)
        describe_security_groups({ filters: [{ name: 'group-name', values: names }] })
      end

      def select_security_group_by_tag_name(names)
        describe_security_groups({ filters: [{ name: 'tag:Name', values: names }] })
      end

      def describe_security_groups(param)
        ec2_client.describe_security_groups(param).security_groups
      end
    end
  end
end
