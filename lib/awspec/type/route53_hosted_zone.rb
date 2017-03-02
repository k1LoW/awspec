module Awspec::Type
  class Route53HostedZone < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_hosted_zone(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    def resource_via_client_record_sets
      @resource_via_client_record_sets ||= select_record_sets_by_hosted_zone_id(id)
    end

    def has_record_set?(name, type, value, options = {})
      name.gsub!(/\*/, '\\\052') # wildcard support
      ret = resource_via_client_record_sets.find do |record_set|
        # next if record_set.type != type.upcase
        next unless record_set.type.casecmp(type) == 0
        options[:ttl] = record_set[:ttl] unless options[:ttl]
        if !record_set.resource_records.empty?
          v = record_set.resource_records.map { |r| r.value }.join("\n")
          record_set.name == name && \
          value == v && \
          record_set.ttl == options[:ttl]
        else
          # ALIAS
          record_set.name == name && \
          record_set.alias_target.dns_name == options[:alias_dns_name] && \
          record_set.alias_target.hosted_zone_id == options[:alias_hosted_zone_id]
        end
      end
    end
  end
end
