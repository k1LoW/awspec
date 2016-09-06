module Awspec::Generator
  module Doc
    module Type
      class WafWebAcl < Base
        def initialize
          super
          @type_name = 'WafWebAcl'
          @type = Awspec::Type::WafWebAcl.new('my-waf-web-acl')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = %w(default_action)
        end
      end
    end
  end
end
