module Awspec::Generator
  module Doc
    module Type
      class TransitGateway < Base
        def initialize
          super
          @type_name = 'TransitGateway'
          @type = Awspec::Type::TransitGateway.new('my-transit-gateway')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
