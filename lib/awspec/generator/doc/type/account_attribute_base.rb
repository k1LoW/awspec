module Awspec::Generator
  module Doc
    module Type
      class AccountAttributeBase < Base
        def initialize
          Awspec::Stub.load 'account'
          @type_name = type_name
        end
      end
    end
  end
end
