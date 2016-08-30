module Awspec::Helper
  module Finder
    module Elasticsearch
      def find_elasticsearch_domain(id)
        res = elasticsearch_client.describe_elasticsearch_domain(domain_name: id)
        res.domain_status
      rescue
        nil
      end

      def select_all_elasticsearch_domains
        domain_names = elastisearch_client.list_domain_names
        domain_names.map do |domain_name|
          elasticsearch_client.describe_elasticsearch_domain(domain_name)
        end
      end
    end
  end
end
