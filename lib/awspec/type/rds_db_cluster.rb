# frozen_string_literal: true

module Awspec::Type
  class RdsDbCluster < ResourceBase
    aws_resource Aws::RDS::Types::DBCluster

    def resource_via_client
      @resource_via_client ||= find_db_cluster(@display_name)
    end

    def id
      @id ||= resource_via_client.db_cluster_identifier if resource_via_client
    end

    STATES = %w[
      available creating deleting
    ]

    STATES.each do |state|
      define_method "#{state.tr('-', '_')}?" do
        resource_via_client.status == state
      end
    end

    def has_security_group?(sg_id)
      return true if has_vpc_security_group_id?(sg_id)
      return true if has_vpc_security_group_name?(sg_id)
      return true if has_vpc_security_group_tag_name?(sg_id)
    end

    def has_cluster_member?(db_instance_identifier, is_writer = nil)
      members = resource_via_client.db_cluster_members
      members.find do |member|
        if is_writer.nil?
          member.db_instance_identifier == db_instance_identifier
        else
          member.db_instance_identifier == db_instance_identifier && member.is_cluster_writer == is_writer
        end
      end
    end

    private

    def has_vpc_security_group_id?(sg_id)
      sgs = resource_via_client.vpc_security_groups
      sgs.find do |sg|
        sg.vpc_security_group_id == sg_id
      end
    end

    def has_vpc_security_group_name?(sg_id)
      sgs = resource_via_client.vpc_security_groups
      res = ec2_client.describe_security_groups({
                                                  filters: [{ name: 'group-name', values: [sg_id] }]
                                                })
      return false unless res.security_groups.count == 1

      sgs.find do |sg|
        sg.vpc_security_group_id == res.security_groups.first.group_id
      end
    end

    def has_vpc_security_group_tag_name?(sg_id)
      sgs = resource_via_client.vpc_security_groups
      res = ec2_client.describe_security_groups({
                                                  filters: [{ name: 'tag:Name', values: [sg_id] }]
                                                })
      return false unless res.security_groups.count == 1

      sgs.find do |sg|
        sg.vpc_security_group_id == res.security_groups.first.group_id
      end
    end
  end
end
