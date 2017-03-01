module Awspec::Generator
  module Doc
    module Type
      class InternetGateway < Base
        def initialize
          super
          @type_name = 'InternetGateway'
          @type = Awspec::Type::InternetGateway.new('my-internet-gateway')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
