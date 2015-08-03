module Awspec::Type
  class Route53HostedZone < Base
    attr_reader :hosted_zone, :resource_record_sets

    def initialize(id)
      super
      @hosted_zone = find_hosted_zone(id)
      @id = @hosted_zone[:id] if @hosted_zone
      return unless @id
      res = @route53_client.list_resource_record_sets({
                                                        hosted_zone_id: @id
                                                      })
      @resource_record_sets = res.resource_record_sets
    end

    def has_record_set?(name, type, value, options = {})
      ret = @resource_record_sets.find do |record_set|
        next if record_set.type != type.upcase
        options[:ttl] = record_set.ttl unless options[:ttl]
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

    def method_missing(name)
      describe = name.to_s
      if @hosted_zone.key?(describe)
        @hosted_zone[describe]
      else
        super
      end
    end
  end
end
