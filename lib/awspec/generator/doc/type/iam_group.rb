module Awspec::Generator
  module Doc
    module Type
      class IamGroup < Base
        def initialize
          super
          @type_name = 'IamGroup'
          @type = Awspec::Type::IamGroup.new('my-iam-group')
          @ret = @type.resource
          @matchers = %w(be_allowed_action)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
