module Awspec::Generator
  module Doc
    module Type
      class RdsAccountAttributes < AccountAttributeBase
        def initialize
          super
          @type_name = 'RdsAccountAttributes'
          @type = Awspec::Type::RdsAccountAttributes.new
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
