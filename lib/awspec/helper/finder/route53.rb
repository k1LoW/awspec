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

          break unless res.is_truncated
          res = route53_client.list_hosted_zones({
                                                   marker: res.next_marker
                                                 })
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
          break unless res.is_truncated

          res = route53_client.list_resource_record_sets({
                                                           hosted_zone_id: id,
                                                           start_record_name: res.next_record_name,
                                                           start_record_type: res.next_record_type
                                                         })
        end
        selected
      end
    end
  end
end
