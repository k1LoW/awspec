module Awspec::Generator
  module Doc
    module Type
      class IamUser < Base
        def initialize
          super
          @type_name = 'IamUser'
          @type = Awspec::Type::IamUser.new('my-iam-user')
          @ret = @type.resource_via_client
          @matchers = %w(belong_to_iam_group be_allowed_action)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
