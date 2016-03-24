module Awspec::Generator
  module Doc
    module Type
      class NetworkInterface < Base
        def initialize
          super
          @type_name = 'NetworkInterface'
          @type = Awspec::Type::NetworkInterface.new('eni-12ab3cde')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
