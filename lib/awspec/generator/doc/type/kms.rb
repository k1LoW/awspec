module Awspec::Generator
  module Doc
    module Type
      class Kms < Base
        def initialize
          super
          @type_name = 'Kms'
          @type = Awspec::Type::Kms.new('my-kms-key')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
