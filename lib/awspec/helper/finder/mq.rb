# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Mq
      def find_broker(broker_id)
        mq_client.describe_broker({ broker_id: broker_id })
      rescue StandardError
        nil
      end
    end
  end
end
