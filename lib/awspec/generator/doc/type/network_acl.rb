module Awspec::Generator
  module Doc
    module Type
      class NetworkAcl < Base
        def initialize
          super
          @type_name = 'NetworkAcl'
          @type = Awspec::Type::NetworkAcl.new('my-network-acl')
          @ret = @type.resource
          @matchers = ['its(:inbound), its(:outbound)']
          @ignore_matchers = %w(be_allowed be_denied)
          @describes = %w(inbound_entries_count outbound_entries_count)
        end
      end
    end
  end
end
