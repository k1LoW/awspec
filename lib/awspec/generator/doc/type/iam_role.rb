module Awspec::Generator
  module Doc
    module Type
      class IamRole < Base
        def initialize
          super
          @type_name = 'IamRole'
          @type = Awspec::Type::IamRole.new('my-iam-role')
          @ret = @type.resource_via_client
          @matchers = %w(be_allowed_action)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
