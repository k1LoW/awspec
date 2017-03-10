module Awspec::Generator
  module Doc
    module Type
      class Ec2AccountAttributes < AccountAttributeBase
        def initialize
          super
          @type_name = 'Ec2AccountAttributes'
          @type = Awspec::Type::Ec2AccountAttributes.new
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
