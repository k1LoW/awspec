module Awspec::Helper
  module Finder
    module Firehose
      def find_delivery_stream(name)
        res = firehose_client.describe_delivery_stream({
                                                         delivery_stream_name: name,
                                                         limit: 1
                                                       })
        res.delivery_stream_description
      end
    end
  end
end
