# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class Wafv2WebAcl < Base
        def initialize
          super
          @type_name = 'Wafv2WebAcl'
          @type = Awspec::Type::Wafv2WebAcl.new('my-wafv2-web-acl')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
