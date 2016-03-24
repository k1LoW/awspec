module Awspec::Generator
  module Doc
    module Type
      class NetworkInterface < Base
        def initialize
          super
          @type_name = 'NetworkInterface'
          @type = Awspec::Type::NetworkInterface.new('eni-12ab3cde')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::NetworkInterface::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', '),
            'belong_to_vpc',
            'belong_to_subnet'
          ]
          @ignore_matchers = Awspec::Type::NetworkInterface::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
