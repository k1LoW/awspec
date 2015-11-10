module Awspec::Generator
  module Doc
    module Type
      class NetworkAcl < Base
        def initialize
          super
          @type_name = 'NetworkAcl'
          @type = Awspec::Type::NetworkAcl.new('my-network-acl')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
