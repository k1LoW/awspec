module Awspec::Helper
  module Finder
    module Route53
      def find_hosted_zone(id)
        res = route53_client.list_hosted_zones
        selected = []
        loop do
          res.hosted_zones.each do |hosted_zone|
            if hosted_zone[:name] == id || hosted_zone[:id] == '/hostedzone/' + id || hosted_zone[:id] == id
              selected.push(hosted_zone)
            end
          end
          (res.next_page? && res = res.next_page) || break
        end
        selected.single_resource(id)
      end

      def select_record_sets_by_hosted_zone_id(id)
        selected = []
        res = route53_client.list_resource_record_sets({
                                                         hosted_zone_id: id
                                                       })
        loop do
          selected += res.resource_record_sets
          (res.next_page? && res = res.next_page) || break
        end
        selected
      end
    end
  end
end
