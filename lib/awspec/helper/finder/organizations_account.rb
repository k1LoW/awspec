module Awspec::Helper
  module Finder
    module OrganizationsAccount
      def find_account(name)
        res = organizations_client.list_accounts
        res.accounts.find { |account| account.name == name }
      end
    end
  end
end
