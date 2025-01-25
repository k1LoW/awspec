# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class Wafv2IpSet < Base
        def initialize
          super
          @type_name = 'Wafv2IpSet'
          @type = Awspec::Type::Wafv2IpSet.new('my-ip-set')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
