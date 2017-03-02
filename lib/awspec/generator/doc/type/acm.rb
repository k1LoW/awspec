module Awspec::Generator
  module Doc
    module Type
      class Acm < Base
        def initialize
          super
          @type_name = 'Acm'
          @type = Awspec::Type::Acm.new('example.com')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
