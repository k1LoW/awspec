module Awspec::Generator
  module Doc
    module Type
      class Account < Base
        def initialize
          super
          @type_name = 'Account'
          @type = Awspec::Type::Account.new
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end

        def generate_doc
          '@TODO' + "\n"
        end
      end
    end
  end
end
