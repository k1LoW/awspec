module Awspec::Generator
  module Doc
    module Type
      class VpnGateway < Base
        def initialize
          super
          @type_name = 'VpnGateway'
          @type = Awspec::Type::VpnGateway.new('my-vpn-gateway')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::VpnGateway::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::VpnGateway::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
