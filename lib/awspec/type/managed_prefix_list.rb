# frozen_string_literal: true

module Awspec::Type
  class ManagedPrefixList < ResourceBase
    aws_resource Aws::EC2::Types::ManagedPrefixList
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_managed_prefix_list(@display_name)
    end

    def id
      @id ||= resource_via_client.prefix_list_id if resource_via_client
    end

    def entries
      @entries ||= select_managed_prefix_list_entries(id)
    end

    def has_cidr?(cidr, description = nil)
      entries.find do |entry|
        if description.nil?
          entry.cidr == cidr
        else
          entry.cidr == cidr && entry.description == description
        end
      end
    end

    def entries_count
      entries.length
    end
  end
end
