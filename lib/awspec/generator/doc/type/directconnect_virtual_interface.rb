module Awspec::Generator
  module Doc
    module Type
      class DirectconnectVirtualInterface < Base
        def initialize
          super
          @type_name = 'DirectconnectVirtualInterface'
          @type = Awspec::Type::DirectconnectVirtualInterface.new('my-directconnect-virtual-interface')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
