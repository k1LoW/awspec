module Awspec::Generator
  module Doc
    class SecurityGroup < Base
      def initialize
        @type_name = 'SecurityGroup'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::SecurityGroup.new('my-security-group-name')
        @ret = @type.sg
        @matchers = ['its(:inbound), its(:outbound)']
        @ignore_matchers = %w(be_opened be_inbound_opened be_outbound_opened)
        @describes = %w(ip_permissions_count ip_permissions_egress_count)
      end
    end
  end
end
