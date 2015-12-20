module Awspec::Generator
  module Doc
    module Type
      class NatGateway < Base
        def initialize
          super
          @type_name = 'NatGateway'
          @type = Awspec::Type::NatGateway.new('my-nat-gateway')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
