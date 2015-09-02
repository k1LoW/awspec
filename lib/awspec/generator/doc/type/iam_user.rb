module Awspec::Generator
  module Doc
    module Type
      class IamUser < Base
        def initialize
          super
          @type_name = 'IamUser'
          @type = Awspec::Type::IamUser.new('my-iam-user')
          @ret = @type.user
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
