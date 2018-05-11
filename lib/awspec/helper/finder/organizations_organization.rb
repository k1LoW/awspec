module Awspec::Helper
  module Finder
    module OrganizationsOrganization
      def find_organization
        res = organizations_client.describe_organization
        res.organization || {}
      end
    end
  end
end
