module Awspec::Generator
  module Doc
    module Type
      class IamPolicy < Base
        def initialize
          super
          @type_name = 'IamPolicy'
          @type = Awspec::Type::IamPolicy.new('my-iam-policy')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
