module Awspec::Type
  class Firehose < ResourceBase
    def initialize(name)
      super
      @delivery_stream_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_delivery_stream(@delivery_stream_name)
    end

    def id
      @id ||= @delivery_stream_name if resource_via_client
    end

    STATES = %w(ACTIVE CREATING DELETING)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.delivery_stream_status == state
      end
    end
  end
end
