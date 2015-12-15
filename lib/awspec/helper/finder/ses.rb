module Awspec::Helper
  module Finder
    module Ses
      def find_ses_identity(id)
        res = ses_client.list_identities
        ret = res[:identities].select do |identity|
          identity == id
        end
        ret.first if ret.count == 1
      end
    end
  end
end
