module Awspec::Helper
  module Finder
    module Route53
      def find_hosted_zone(id)
        hosted_zones = {}
        marker = nil
        loop do
          res = @route53_client.list_hosted_zones({
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
    end
  end
end
