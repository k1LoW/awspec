module Awspec::Generator
  module Doc
    module Type
      class OrganizationsAccount < Base
        def initialize
          super
          @type_name = 'OrganizationsAccount'
          @type = Awspec::Type::OrganizationsAccount.new('my-organizations-account')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
