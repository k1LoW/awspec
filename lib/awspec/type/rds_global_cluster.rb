# frozen_string_literal: true

module Awspec::Type
  class RdsGlobalCluster < ResourceBase
    aws_resource Aws::RDS::Types::GlobalCluster

    def resource_via_client
      @resource_via_client ||= find_global_cluster(@display_name)
    end

    def id
      @id ||= resource_via_client.global_cluster_identifier if resource_via_client
    end

    STATES = %w[
      available creating deleting
    ]

    STATES.each do |state|
      define_method "#{state.tr('-', '_')}?" do
        resource_via_client.status == state
      end
    end

    def has_cluster_member?(db_cluster_arn, is_writer = nil)
      members = resource_via_client.global_cluster_members
      members.find do |member|
        if is_writer.nil?
          member.db_cluster_arn == db_cluster_arn
        else
          member.db_cluster_arn == db_cluster_arn && member.is_writer == is_writer
        end
      end
    end
  end
end
