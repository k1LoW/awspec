# frozen_string_literal: true

module Awspec::Type
  class TransferServer < ResourceBase
    attr_reader :id

    tags_allowed

    def initialize(id)
      super
      @id = id
    end

    def resource_via_client
      @resource_via_client ||= find_transfer_server(@id)
    end

    STATES = %w[
      OFFLINE ONLINE STARTING STOPPING START_FAILED STOP_FAILED
    ]

    STATES.each do |state|
      define_method "#{state.downcase.tr('-', '_')}?" do
        resource_via_client.state == state
      end
    end
  end
end
