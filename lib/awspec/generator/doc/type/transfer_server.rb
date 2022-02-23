# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class TransferServer < Base
        def initialize
          super
          @type_name = 'TransferServer'
          @type = Awspec::Type::TransferServer.new('s-4dc0a424f0154fa89')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::TransferServer::STATES.map { |state| "be_#{state.downcase.tr('-', '_')}" }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::TransferServer::STATES.map { |state| "be_#{state.downcase.tr('-', '_')}" }
          @describes = []
        end
      end
    end
  end
end
