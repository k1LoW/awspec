module Awspec::Generator
  module Doc
    module Type
      class NatGateway < Base
        def initialize
          super
          @type_name = 'NatGateway'
          @type = Awspec::Type::NatGateway.new('nat-7ff7777f')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::NatGateway::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', '),
            'belong_to_vpc'
          ]
          @ignore_matchers = Awspec::Type::NatGateway::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
