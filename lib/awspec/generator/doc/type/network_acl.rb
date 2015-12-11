module Awspec::Generator
  module Doc
    module Type
      class NetworkAcl < Base
        def initialize
          super
          @type_name = 'NetworkAcl'
          @type = Awspec::Type::NetworkAcl.new('my-network-acl')
          @ret = @type.resource_via_client
          @matchers = [
            'belong_to_vpc',
            'its(:inbound), its(:outbound), its(:inbound_entries_count), its(:outbound_entries_count)'
          ]
          @ignore_matchers = %w(be_allowed be_denied)
          @describes = %w(inbound_entries_count outbound_entries_count)
        end
      end
    end
  end
end
