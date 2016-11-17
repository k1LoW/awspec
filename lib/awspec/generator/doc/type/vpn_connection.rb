module Awspec::Generator
  module Doc
    module Type
      class VpnConnection < Base
        def initialize
          super
          @type_name = 'VpnConnection'
          @type = Awspec::Type::VpnConnection.new('my-vpn-connection')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::VpnConnection::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::VpnConnection::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
