module Awspec::Generator
  module Doc
    module Type
      class SecurityGroup < Base
        def initialize
          super
          @type = Awspec::Type::SecurityGroup.new('my-security-group-name')
          @ret = @type.sg
          @matchers = ['its(:inbound), its(:outbound)']
          @ignore_matchers = %w(be_opened be_inbound_opened be_outbound_opened)
          @describes = %w(ip_permissions_count ip_permissions_egress_count)
        end
      end
    end
  end
end
