module Awspec::Generator
  module Doc
    module Type
      class Apigateway < Base
        def initialize
          super
          @type_name = 'Apigateway'
          @type = Awspec::Type::Apigateway.new('my-apigateway')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
