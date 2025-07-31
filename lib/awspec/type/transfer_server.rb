# frozen_string_literal: true

module Awspec::Type
  class TransferServer < ResourceBase
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_transfer_server(@display_name)
    end

    def id
      @id ||= resource_via_client.server_id if resource_via_client
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
