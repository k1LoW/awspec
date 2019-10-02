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
      name = name.gsub(/\*/, '\\\052') # wildcard support

      record_sets = resource_via_client_record_sets.select { |record| record.name == name }
      return false if record_sets.empty?

      # Check if the given record is registered regardless of type and value
      return true if type.nil? && value.nil? && options.nil?

      record_sets.select! { |record_set| record_set.type.casecmp(type) == 0 }
      return !record_sets.empty? if value.nil? && options.nil? || value.nil? && options.empty?

      return match_failover_record(record_sets, name, value, options) if options[:record_type]

      record_sets.each do |record_set|
        return match_record(record_set, name, value, options) unless record_set.resource_records.empty?
        return match_alias_record(record_set, name, options)
      end
    end

    private

    def match_failover_record(record_sets, name, value, options)
      record_sets.select! { |record_set| record_set.failover == options[:record_type] }
      return false if record_sets.empty?
      record_sets.each do |record_set|
        return match_alias_record(record_set, name, options) if value.nil?
        return match_record(record_set, name, value, options)
      end
    end

    def match_record(record_set, name, value, options)
      sorted = record_set.resource_records.map { |r| r.value }.sort.join("\n")

      if !options.empty? && options[:ttl]
        return (record_set.name == name && \
          value.split("\n").sort.join("\n") == sorted && \
          record_set.ttl == options[:ttl])
      end

      record_set.name == name && \
        value.split("\n").sort.join("\n") == sorted
    end

    def match_alias_record(record_set, name, options)
      record_set.name == name && \
      record_set.alias_target.dns_name == options[:alias_dns_name] && \
      record_set.alias_target.hosted_zone_id == options[:alias_hosted_zone_id]
    end
  end
end
