module Awspec::Type
  class Firehose < ResourceBase

    def initialize(name)
      super
      @delivery_stream_name = name
    end

    def resource_via_client
      puts 'hello ' + @delivery_stream_name
      @resource_via_client ||= find_delivery_stream(@delivery_stream_name)
    end

    def id
     @id ||= @delivery_stream_name if resource_via_client
    end
  end
end
