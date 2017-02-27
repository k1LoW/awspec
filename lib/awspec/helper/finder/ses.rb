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

      def find_ses_send_quota
        ses_client.get_send_quota
      end
    end
  end
end
