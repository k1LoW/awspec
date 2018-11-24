module Awspec::Helper
  module Finder
    module Sqs
      def find_queue(queue_name)
        res = sqs_client.list_queues(queue_name_prefix: queue_name).queue_urls.select do |url|
          url.split('/').last == queue_name
        end
        res.single_resource(queue_name)
      end

      def find_tags_for_queue(queue_url)
        res = sqs_client.list_queue_tags({ queue_url: queue_url })
        res.tags
      end
    end
  end
end
