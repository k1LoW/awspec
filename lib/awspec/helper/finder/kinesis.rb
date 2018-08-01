module Awspec::Helper
  module Finder
    module Kinesis
      def find_kinesis_by_stream_name(name)
        list_of_streams = kinesis_client.list_streams
        list_of_streams.stream_names.each do |stream|
          if stream == name
            res = kinesis_client.describe_stream_summary({ stream_name: name })
            raise('find_kinesis_by_stream_name FAILING!') if res.nil?
            return res
          end
        end
        nil
      end
    end
  end
end
