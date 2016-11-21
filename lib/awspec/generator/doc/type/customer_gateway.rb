module Awspec::Generator
  module Doc
    module Type
      class CustomerGateway < Base
        def initialize
          super
          @type_name = 'CustomerGateway'
          @type = Awspec::Type::CustomerGateway.new('my-customer-gateway')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::CustomerGateway::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::CustomerGateway::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
