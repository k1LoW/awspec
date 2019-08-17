module Awspec::Helper
  module Finder
    module Secretsmanager
      def find_secret(id)
        secretsmanager_client.describe_secret({
                                                secret_id: id
                                              })
      end
    end
  end
end
