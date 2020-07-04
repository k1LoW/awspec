module Awspec::Generator
  module Doc
    module Type
      class CognitoIdentityPool < Base
        def initialize
          super
          @type_name = 'CognitoIdentityPool'
          @type = Awspec::Type::CognitoIdentityPool.new('my-cognito-identity-pool')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
