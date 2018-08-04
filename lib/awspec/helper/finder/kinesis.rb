module Awspec::Helper
  module Finder
    module Kinesis
      def find_kinesis_by_stream_name(name)
        kinesis_client.list_streams.stream_names.each do |stream|
          if stream == name
            return kinesis_client.describe_stream_summary({ stream_name: name }).stream_description_summary
          end
        end
        nil
      end
    end
  end
end
