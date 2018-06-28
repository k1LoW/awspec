module Awspec::Generator
  module Doc
    module Type
      class SsmParameter < Base
        def initialize
          super
          @type_name = 'SsmParameter'
          @type = Awspec::Type::SsmParameter.new('my-ssm')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
