module Awspec::Helper
  module Finder
    module Kms
      def find_kms_key(key_id)
        kms_client.describe_key(key_id: key_id).key_metadata
      rescue
        nil
      end

      def find_kms_key_by_alias(key_alias_name)
        key = kms_client.list_aliases.aliases.find do |key_alias|
          key_alias.alias_name == "alias/#{key_alias_name}"
        end
        find_kms_key(key.target_key_id)
      end

      def select_all_kms_aliases
        kms_client.list_aliases.aliases
      end
    end
  end
end
