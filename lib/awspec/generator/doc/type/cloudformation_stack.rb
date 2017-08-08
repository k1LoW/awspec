module Awspec::Generator
  module Doc
    module Type
      class CloudformationStack < Base
        def initialize
          super
          @type_name = 'CloudformationStack'
          @type = Awspec::Type::CloudformationStack.new('my-cloudformation-stack')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
