# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Transfer
      def find_transfer_server(id)
        res = transfer_client.describe_server(server_id: id)
        res.server
      end
    end
  end
end
