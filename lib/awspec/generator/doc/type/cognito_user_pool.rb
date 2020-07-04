module Awspec::Generator
  module Doc
    module Type
      class CognitoUserPool < Base
        def initialize
          super
          @type_name = 'CognitoUserPool'
          @type = Awspec::Type::CognitoUserPool.new('my-cognito-user-pool')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
