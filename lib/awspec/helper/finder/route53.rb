module Awspec::Helper
  module Finder
    module Route53
      def find_hosted_zone(id)
        res = @route53_client.list_hosted_zones
        loop do
          res.hosted_zones.each do |hosted_zone|
            if hosted_zone[:name] == id || hosted_zone[:id] == '/hostedzone/' + id || hosted_zone[:id] == id
              return hosted_zone
            end
          end
          (res.next_page? && res = res.next_page) || break
        end
      end
    end
  end
end
