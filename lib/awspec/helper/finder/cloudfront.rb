module Awspec::Helper
  module Finder
    module Cloudfront
      def find_cloudfront_distribution(id)
        selected = []
        res = cloudfront_client.list_distributions
        loop do
          selected += res.distribution_list.items.select do |item|
            item.id == id || item.domain_name == id
          end
          break unless res.distribution_list.is_truncated
          res = cloudfront_client.list_distributions({
                                                       marker: res.distribution_list.next_marker
                                                     })
        end

        selected.single_resource(id)
      end
    end
  end
end
