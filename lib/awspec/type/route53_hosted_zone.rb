module Awspec::Type
  class Route53HostedZone < Base
    attr_reader :hosted_zone

    def initialize(id)
      super
      @client = Aws::Route53::Client.new
      @hosted_zone = find_hosted_zone(id)
      @id = @hosted_zone[:id] if @hosted_zone
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
