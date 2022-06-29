# frozen_string_literal: true

module Awspec::Type
  class RdsProxy < ResourceBase
    aws_resource Aws::RDS::Types::DBProxy

    def resource_via_client
      @resource_via_client ||= find_rds_proxy(@display_name)
    end

    def id
      @id ||= resource_via_client.db_proxy_name if resource_via_client
    end

    STATES = %w[
      available creating deleting incompatible-network
      insufficient-resource-limits modifying reactivating
      suspended suspending
    ]

    STATES.each do |state|
      define_method "#{state.tr('-', '_')}?" do
        resource_via_client.status == state
      end
    end

    def vpc_id
      resource_via_client.vpc_id
    end

    def has_security_group?(sg_id)
      return true if has_vpc_security_group_id?(sg_id)
      return true if has_vpc_security_group_name?(sg_id)
      return true if has_vpc_security_group_tag_name?(sg_id)
    end

    private

    def has_vpc_security_group_id?(sg_id)
      resource_via_client.vpc_security_group_ids.include?(sg_id)
    end

    def has_vpc_security_group_name?(sg_id)
      sgs = resource_via_client.vpc_security_group_ids
      res = ec2_client.describe_security_groups({
                                                  filters: [{ name: 'group-name', values: [sg_id] }]
                                                })
      return false unless res.security_groups.count == 1

      sgs.find do |sg|
        sg == res.security_groups.first.group_id
      end
    end

    def has_vpc_security_group_tag_name?(sg_id)
      sgs = resource_via_client.vpc_security_group_ids
      res = ec2_client.describe_security_groups({
                                                  filters: [{ name: 'tag:Name', values: [sg_id] }]
                                                })
      return false unless res.security_groups.count == 1

      sgs.find do |sg|
        sg == res.security_groups.first.group_id
      end
    end
  end
end
