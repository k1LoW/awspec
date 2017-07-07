module Awspec::Helper
  module Finder
    module Sqs
      def find_queue(queue_name)
        res = sqs_client.list_queues(queue_name_prefix: queue_name).queue_urls.select do |url|
          url.split('/').last == queue_name
        end
        res.single_resource(queue_name)
      end
    end
  end
end
