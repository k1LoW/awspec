module Awspec::Generator
  module Doc
    module Type
      class WafregionalWebAcl < Base
        def initialize
          super
          @type_name = 'WafregionalWebAcl'
          @type = Awspec::Type::WafregionalWebAcl.new('my-wafregional-web-acl')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = %w(default_action)
        end
      end
    end
  end
end
