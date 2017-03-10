module Awspec::Generator
  module Doc
    module Type
      class LambdaAccountSettings < AccountAttributeBase
        def initialize
          super
          @type_name = 'LambdaAccountSettings'
          @type = Awspec::Type::LambdaAccountSettings.new
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
