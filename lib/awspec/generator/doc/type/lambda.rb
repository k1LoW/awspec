module Awspec::Generator
  module Doc
    module Type
      class Lambda < Base
        def initialize
          super
          @type_name = 'Lambda'
          @type = Awspec::Type::Lambda.new('my-lambda-function-name')
          @ret = @type.resource_via_client
          @matchers = %w(have_env_var have_env_vars)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
