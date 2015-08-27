module Awspec::Generator
  module Doc
    module Type
      class Lambda < Base
        def initialize
          super
          @type_name = 'Lambda'
          @type = Awspec::Type::Lambda.new('my-lambda-function-name')
          @ret = @type.function
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
