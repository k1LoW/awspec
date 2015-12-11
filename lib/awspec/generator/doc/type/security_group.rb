module Awspec::Generator
  module Doc
    module Type
      class SecurityGroup < Base
        def initialize
          super
          @type = Awspec::Type::SecurityGroup.new('my-security-group-name')
          @ret = @type.resource_via_client
          @matchers = ['its(:inbound), its(:outbound)']
          @ignore_matchers = %w(be_opened be_inbound_opened be_outbound_opened)
          @describes = %w(inbound_rule_count outbound_rule_count inbound_permissions_count outbound_permissions_count)
        end
      end
    end
  end
end
