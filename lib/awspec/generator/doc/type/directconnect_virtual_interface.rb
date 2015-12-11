module Awspec::Generator
  module Doc
    module Type
      class DirectconnectVirtualInterface < Base
        def initialize
          super
          @type_name = 'DirectconnectVirtualInterface'
          @type = Awspec::Type::DirectconnectVirtualInterface.new('my-directconnect-virtual-interface')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::DirectconnectVirtualInterface::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::DirectconnectVirtualInterface::STATES.map do |state|
            'be_' + state.tr('-', '_')
          end
          @describes = []
        end
      end
    end
  end
end
