module Awspec::Generator
  module Doc
    module Type
      class Msk < Base
        def initialize
          super
          @type_name = 'Msk'
          @type = Awspec::Type::Msk.new('my-msk')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
