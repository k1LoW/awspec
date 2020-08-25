module Awspec::Generator
  module Doc
    module Type
      class VpcEndpoints < Base
        def initialize
          super
          @type_name = 'VpcEndpoints'
          @type = Awspec::Type::VpcEndpoints.new('my-vpc-endpoint')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
