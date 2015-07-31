module Awspec::Type
  class Route53HostedZone < Base
    attr_reader :hosted_zone, :resource_record_sets

    def initialize(id)
      super
      @client = Aws::Route53::Client.new
      @hosted_zone = find_hosted_zone(id)
      @id = @hosted_zone[:id] if @hosted_zone
      return unless @id
      res = @client.list_resource_record_sets({
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

    def find_hosted_zone(id)
      hosted_zones = {}
      marker = nil
      loop do
        res = @client.list_hosted_zones({
                                          marker: marker
                                        })
        marker = res.marker
        break if res.hosted_zones.empty?
        res.hosted_zones.each do |hosted_zone|
          hosted_zones[hosted_zone[:name]] = hosted_zones
          if hosted_zone[:name] == id || hosted_zone[:id] == '/hostedzone/' + id || hosted_zone[:id] == id
            return hosted_zone
          end
        end

        break if marker.nil?
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
