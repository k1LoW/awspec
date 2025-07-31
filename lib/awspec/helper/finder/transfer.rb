# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Transfer
      def find_transfer_server(id)
        res = transfer_client.describe_server({ server_id: id })
        res.server
      rescue Aws::Transfer::Errors::ValidationException, Aws::Transfer::Errors::ResourceNotFoundException
        req = {}
        servers = []
        loop do
          res = transfer_client.list_servers(req)
          servers.push(*res.servers)
          break if res.next_token.nil?

          req[:next_token] = res.next_token
        end

        servers.each do |s|
          server = transfer_client.describe_server({ server_id: s.server_id }).server
          server.tags.each do |tag|
            if tag.key == 'Name' && tag.value == id
              return server
            end
          end
        end
        nil
      end
    end
  end
end
