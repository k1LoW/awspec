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
          (res.next_page? && res = res.next_page) || break
        end

        selected.single_resource(id)
      end
    end
  end
end
