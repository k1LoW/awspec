# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class ManagedPrefixList < Base
        def initialize
          super
          @type_name = 'ManagedPrefixList'
          @type = Awspec::Type::ManagedPrefixList.new('my-managed-prefix-list')
          @ret = @type.resource_via_client
          @matchers = ['its(:entries_count)']
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
