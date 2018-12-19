module Awspec::Helper
  module Finder
    module Kms
      def find_kms_key(key_id)
        kms_client.describe_key(key_id: key_id).key_metadata
      rescue
        nil
      end

      def find_kms_key_by_alias(key_alias_name)
        alias_name = key_alias_name.start_with?('alias/') ? key_alias_name : "alias/#{key_alias_name}"
        found = nil
        next_marker = nil

        loop do
          res = kms_client.list_aliases(marker: next_marker, limit: 100)
          found = res.aliases.find { |key_alias| key_alias.alias_name == alias_name }
          (found.nil? && next_marker = res.next_marker) || break
        end

        find_kms_key(found.target_key_id) if found
      end

      def select_all_kms_aliases
        all_aliases = []
        next_marker = nil

        loop do
          res = kms_client.list_aliases(marker: next_marker, limit: 100)
          all_aliases.concat(res.aliases)
          next_marker = res.next_marker || break
        end

        all_aliases
      end
    end
  end
end
