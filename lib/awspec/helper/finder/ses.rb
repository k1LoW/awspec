module Awspec::Helper
  module Finder
    module Ses
      def find_ses_identity(id)
        res = ses_client.list_identities
        ret = res.identities.select do |identity|
          identity == id
        end
        ret.single_resource(id)
      end
    end
  end
end
