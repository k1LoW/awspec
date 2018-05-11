module Awspec::Generator
  module Doc
    module Type
      class OrganizationsOrganization < Base
        def initialize
          super
          @type_name = 'OrganizationsOrganization'
          @type = Awspec::Type::OrganizationsOrganization.new('o-exampleorgid')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
