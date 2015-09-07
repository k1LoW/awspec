module Awspec::Generator
  module Doc
    module Type
      class IamRole < Base
        def initialize
          super
          @type_name = 'IamRole'
          @type = Awspec::Type::IamRole.new('my-iam-role')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
